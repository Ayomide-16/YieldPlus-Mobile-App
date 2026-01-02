import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../services/edge_function_service.dart';
import 'dart:convert';

class SoilAdvisorScreen extends StatefulWidget {
  const SoilAdvisorScreen({super.key});

  @override
  State<SoilAdvisorScreen> createState() => _SoilAdvisorScreenState();
}

class _SoilAdvisorScreenState extends State<SoilAdvisorScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedColor = 'Dark Brown';
  String _selectedTexture = 'Loamy';
  String _selectedPH = 'Neutral';
  String _selectedCompactness = 'Medium';
  final _notesController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _analysisResult;

  final _colorOptions = ['Dark Brown', 'Light Brown', 'Black', 'Red', 'Yellow', 'Grey'];
  final _textureOptions = ['Sandy', 'Loamy', 'Clay', 'Silty', 'Peaty', 'Chalky'];
  final _phOptions = ['Acidic', 'Slightly Acidic', 'Neutral', 'Slightly Alkaline', 'Alkaline'];
  final _compactnessOptions = ['Loose', 'Medium', 'Compact', 'Very Compact'];

  Future<void> _analyzeSoil() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; _analysisResult = null; });

    try {
      final result = await EdgeFunctionService.analyzeSoil(
        color: _selectedColor, texture: _selectedTexture, soilPH: _selectedPH, soilCompactness: _selectedCompactness, notes: _notesController.text,
      );
      if (result.containsKey('analysis')) {
        final analysisStr = result['analysis'] as String;
        try { _analysisResult = jsonDecode(analysisStr); } catch (e) { _analysisResult = {'rawAnalysis': analysisStr}; }
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soil Nutrient Advisor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Soil Color', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(value: _selectedColor, items: _colorOptions.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => _selectedColor = v!), decoration: const InputDecoration(border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      const Text('Soil Texture', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(value: _selectedTexture, items: _textureOptions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => setState(() => _selectedTexture = v!), decoration: const InputDecoration(border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      const Text('pH Level', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(value: _selectedPH, items: _phOptions.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (v) => setState(() => _selectedPH = v!), decoration: const InputDecoration(border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      const Text('Compactness', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(value: _selectedCompactness, items: _compactnessOptions.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => _selectedCompactness = v!), decoration: const InputDecoration(border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      const Text('Additional Notes', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextFormField(controller: _notesController, maxLines: 3, decoration: const InputDecoration(hintText: 'Any additional observations...', border: OutlineInputBorder())),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _isLoading ? null : _analyzeSoil, child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Analyze Soil')),
              if (_analysisResult != null) ...[
                const SizedBox(height: 24),
                Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Icon(Icons.check_circle, color: AppColors.primary), const SizedBox(width: 8), Text('Analysis Complete', style: Theme.of(context).textTheme.titleMedium)]), const Divider(), Text(_analysisResult.toString())]))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
