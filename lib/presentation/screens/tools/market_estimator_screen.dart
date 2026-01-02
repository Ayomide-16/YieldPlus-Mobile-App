import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class MarketEstimatorScreen extends StatelessWidget {
  const MarketEstimatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Market Price Estimator')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.trending_up, size: 64, color: Colors.orange),
              ),
              const SizedBox(height: 24),
              Text('Market Prices', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Text('Check real-time market trends', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              const Text('Coming Soon', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
