import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../services/edge_function_service.dart';
import 'dart:convert';

class CropPlannerScreen extends StatefulWidget {
  const CropPlannerScreen({super.key});

  @override
  State<CropPlannerScreen> createState() => _CropPlannerScreenState();
}

class _CropPlannerScreenState extends State<CropPlannerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cropController = TextEditingController();
  String _selectedCountry = 'Nigeria';
  String _selectedState = 'Lagos';
  double _farmSize = 1.0;
  String _selectedSoilType = 'Loamy';
  bool _isLoading = false;
  Map<String, dynamic>? _analysisResult;

  final _countries = ['Nigeria', 'Ghana', 'Kenya', 'South Africa', 'Tanzania'];
  final _nigeriaStates = ['Lagos', 'Kano', 'Oyo', 'Kaduna', 'Rivers', 'Ogun', 'Abuja FCT'];
  final _soilTypes = ['Sandy', 'Loamy', 'Clay', 'Silty', 'Peaty'];

  Future<void> _analyzeCrop() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; _analysisResult = null; });

    try {
      final result = await EdgeFunctionService.analyzeCrop(
        cropName: _cropController.text,
        location: {'country': _selectedCountry, 'state': _selectedState},
        farmSize: _farmSize,
        soilType: _selectedSoilType,
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
      appBar: AppBar(title: const Text('Crop Planner')),
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
                      const Text('Crop Name', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextFormField(controller: _cropController, decoration: const InputDecoration(hintText: 'e.g., Maize, Cassava, Rice', border: OutlineInputBorder()), validator: (v) => v?.isEmpty ?? true ? 'Please enter a crop name' : null),
                      const SizedBox(height: 16),
                      const Text('Country', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(value: _selectedCountry, items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => _selectedCountry = v!), decoration: const InputDecoration(border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      const Text('State/Region', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(value: _selectedState, items: _nigeriaStates.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => setState(() => _selectedState = v!), decoration: const InputDecoration(border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      Text('Farm Size: ${_farmSize.toStringAsFixed(1)} hectares', style: const TextStyle(fontWeight: FontWeight.w600)),
                      Slider(value: _farmSize, min: 0.1, max: 100, divisions: 100, onChanged: (v) => setState(() => _farmSize = v)),
                      const SizedBox(height: 16),
                      const Text('Soil Type', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(value: _selectedSoilType, items: _soilTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => setState(() => _selectedSoilType = v!), decoration: const InputDecoration(border: OutlineInputBorder())),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _isLoading ? null : _analyzeCrop, child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Get Recommendations')),
              if (_analysisResult != null) ...[
                const SizedBox(height: 24),
                Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Icon(Icons.check_circle, color: AppColors.primary), const SizedBox(width: 8), Text('Crop Analysis', style: Theme.of(context).textTheme.titleMedium)]), const Divider(), Text(_analysisResult.toString())]))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
