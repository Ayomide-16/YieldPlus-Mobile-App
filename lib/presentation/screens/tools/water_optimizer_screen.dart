import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class WaterOptimizerScreen extends StatelessWidget {
  const WaterOptimizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water Usage Optimizer')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.water_drop, size: 64, color: Colors.blue),
              ),
              const SizedBox(height: 24),
              Text('Water Optimizer', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Text('Optimize your irrigation schedule', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              const Text('Coming Soon', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
