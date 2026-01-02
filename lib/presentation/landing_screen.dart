import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 1),
              // Logo and Branding
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.eco, size: 60, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              Text(
                'YieldPlus.AI',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AI-Powered Farm Management\nat Your Fingertips',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 1),
              // Feature Highlights
              _buildFeatureItem(context, Icons.grass, 'Smart Crop Recommendations', 'AI-powered suggestions for optimal yields'),
              const SizedBox(height: 16),
              _buildFeatureItem(context, Icons.analytics, 'Farm Analytics & Insights', 'Data-driven decisions for your farm'),
              const SizedBox(height: 16),
              _buildFeatureItem(context, Icons.science, 'Soil & Pest Analysis', 'Identify issues before they spread'),
              const SizedBox(height: 16),
              _buildFeatureItem(context, Icons.trending_up, 'Market Price Tracking', 'Get the best prices for your produce'),
              const Spacer(flex: 2),
              // Action Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: const Text('I Already Have an Account'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
