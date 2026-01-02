import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class PestIdentifierScreen extends StatelessWidget {
  const PestIdentifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pest Identifier')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.bug_report, size: 64, color: Colors.red),
              ),
              const SizedBox(height: 24),
              Text('Pest Identifier', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Text('Identify pests and diseases', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              const Text('Coming Soon', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
