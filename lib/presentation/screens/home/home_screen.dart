import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/colors.dart';
import '../../../services/auth_service.dart';
import '../../widgets/common/theme_selector_widget.dart';
import '../tools/soil_advisor_screen.dart';
import '../tools/crop_planner_screen.dart';
import '../tools/water_optimizer_screen.dart';
import '../tools/market_estimator_screen.dart';
import '../tools/pest_identifier_screen.dart';
import '../farm/farm_list_screen.dart';
import '../plans/my_plans_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.agriculture_outlined), selectedIcon: Icon(Icons.agriculture), label: 'My Farms'),
          NavigationDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description), label: 'My Plans'),
          NavigationDestination(icon: Icon(Icons.person_outlined), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0: return _buildDashboard();
      case 1: return const FarmListScreen();
      case 2: return const MyPlansScreen();
      case 3: return _buildProfile();
      default: return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    final authService = Provider.of<AuthService>(context);
    final userName = authService.user?.userMetadata?['full_name'] ?? 'Farmer';

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, $userName', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              const Text('YieldPlus.AI', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: const [
            ThemeSelectorWidget(),
            SizedBox(width: 8),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.eco, color: AppColors.primary, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Farm Smarter, Not Harder', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            const Text('AI-powered insights for your farm', style: TextStyle(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('AI-Powered Tools', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildToolsGrid(),
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildToolsGrid() {
    final tools = [
      _ToolItem(icon: Icons.science, title: 'Soil Advisor', subtitle: 'Analyze soil', color: Colors.brown, onTap: () => _navigateTo(const SoilAdvisorScreen())),
      _ToolItem(icon: Icons.grass, title: 'Crop Planner', subtitle: 'Plan crops', color: Colors.green, onTap: () => _navigateTo(const CropPlannerScreen())),
      _ToolItem(icon: Icons.water_drop, title: 'Water Optimizer', subtitle: 'Optimize irrigation', color: Colors.blue, onTap: () => _navigateTo(const WaterOptimizerScreen())),
      _ToolItem(icon: Icons.trending_up, title: 'Market Prices', subtitle: 'Check trends', color: Colors.orange, onTap: () => _navigateTo(const MarketEstimatorScreen())),
      _ToolItem(icon: Icons.bug_report, title: 'Pest Identifier', subtitle: 'Identify pests', color: Colors.red, onTap: () => _navigateTo(const PestIdentifierScreen())),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.1),
      itemCount: tools.length,
      itemBuilder: (context, index) {
        final tool = tools[index];
        return Card(
          child: InkWell(
            onTap: tool.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: tool.color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(tool.icon, color: tool.color, size: 24)),
                  const Spacer(),
                  Text(tool.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(tool.subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfile() {
    final authService = Provider.of<AuthService>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [ThemeSelectorWidget()],
            ),
            const SizedBox(height: 24),
            CircleAvatar(radius: 48, backgroundColor: AppColors.primary.withOpacity(0.1), child: const Icon(Icons.person, size: 48, color: AppColors.primary)),
            const SizedBox(height: 16),
            Text(authService.user?.userMetadata?['full_name'] ?? 'User', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            Text(authService.user?.email ?? '', style: const TextStyle(color: AppColors.textSecondary)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async { await authService.signOut(); },
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error), padding: const EdgeInsets.all(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _ToolItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  _ToolItem({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});
}
