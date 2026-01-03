import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
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
      appBar: AppBar(
        title: const Text('Soil Advisor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(Icons.science_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AI Soil Analysis', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Get nutrient insights', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.9))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Form Fields
              _buildSectionCard(
                title: 'Soil Properties',
                children: [
                  _buildDropdown('Soil Color', _selectedColor, _colorOptions, (v) => setState(() => _selectedColor = v!)),
                  const SizedBox(height: AppSpacing.md),
                  _buildDropdown('Soil Texture', _selectedTexture, _textureOptions, (v) => setState(() => _selectedTexture = v!)),
                  const SizedBox(height: AppSpacing.md),
                  _buildDropdown('pH Level', _selectedPH, _phOptions, (v) => setState(() => _selectedPH = v!)),
                  const SizedBox(height: AppSpacing.md),
                  _buildDropdown('Compactness', _selectedCompactness, _compactnessOptions, (v) => setState(() => _selectedCompactness = v!)),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              _buildSectionCard(
                title: 'Additional Notes',
                children: [
                  TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(hintText: 'Any additional observations about your soil...'),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // Analyze Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _analyzeSoil,
                icon: _isLoading 
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.auto_awesome),
                label: Text(_isLoading ? 'Analyzing...' : 'Analyze Soil'),
              ),

              // Results
              if (_analysisResult != null) ...[
                const SizedBox(height: AppSpacing.xl),
                _buildResultsCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.gray200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.md),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.xs),
        DropdownButtonFormField<String>(
          value: value,
          items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        ),
      ],
    );
  }

  Widget _buildResultsCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.success.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(AppRadius.sm)),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text('Analysis Complete', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 24),
          Text(_formatResults(_analysisResult!), style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  String _formatResults(Map<String, dynamic> data) {
    if (data.containsKey('rawAnalysis')) return data['rawAnalysis'].toString();
    return data.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }
}
