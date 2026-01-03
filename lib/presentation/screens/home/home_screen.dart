import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../services/auth_service.dart';
import '../../providers/theme_provider.dart';
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _DashboardView(),
          const FarmListScreen(),
          const MyPlansScreen(),
          _ProfileView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.agriculture_outlined), selectedIcon: Icon(Icons.agriculture), label: 'Farms'),
          NavigationDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description), label: 'Plans'),
          NavigationDestination(icon: Icon(Icons.person_outlined), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userName = authService.user?.userMetadata?['full_name'] ?? 'Farmer';
    final greeting = _getGreeting();

    return CustomScrollView(
      slivers: [
        // Modern App Bar
        SliverAppBar(
          floating: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.eco_rounded, color: Colors.white, size: 24),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$greeting,', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
                    Text(userName, style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
            ],
          ),
          actions: const [ThemeSelectorWidget(), SizedBox(width: AppSpacing.sm)],
        ),

        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Hero Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Farm Smarter', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                          const SizedBox(height: AppSpacing.xs),
                          Text('AI insights for better yields', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9))),
                          const SizedBox(height: AppSpacing.md),
                          ElevatedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SoilAdvisorScreen())),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                            child: const Text('Start Analysis'),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.eco_rounded, size: 80, color: Colors.white24),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Quick Stats
              Text('Quick Stats', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(child: _StatCard(icon: Icons.agriculture, label: 'Farms', value: '3', color: AppColors.primary)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _StatCard(icon: Icons.grass, label: 'Crops', value: '12', color: Color(0xFF8B5CF6))),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _StatCard(icon: Icons.description, label: 'Plans', value: '5', color: Color(0xFFF59E0B))),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // AI Tools Section
              Text('AI-Powered Tools', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              _buildToolsGrid(context),

              const SizedBox(height: AppSpacing.lg),
            ]),
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  Widget _buildToolsGrid(BuildContext context) {
    final tools = [
      _ToolData(icon: Icons.science_rounded, title: 'Soil Advisor', color: Color(0xFF8B5CF6), screen: const SoilAdvisorScreen()),
      _ToolData(icon: Icons.grass_rounded, title: 'Crop Planner', color: Color(0xFF10B981), screen: const CropPlannerScreen()),
      _ToolData(icon: Icons.water_drop_rounded, title: 'Water Usage', color: Color(0xFF3B82F6), screen: const WaterOptimizerScreen()),
      _ToolData(icon: Icons.trending_up_rounded, title: 'Market Prices', color: Color(0xFFF59E0B), screen: const MarketEstimatorScreen()),
      _ToolData(icon: Icons.bug_report_rounded, title: 'Pest Identifier', color: Color(0xFFEF4444), screen: const PestIdentifierScreen()),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.4),
      itemCount: tools.length,
      itemBuilder: (context, index) {
        final tool = tools[index];
        return _ToolCard(tool: tool, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => tool.screen)));
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.gray200, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _ToolData {
  final IconData icon;
  final String title;
  final Color color;
  final Widget screen;
  _ToolData({required this.icon, required this.title, required this.color, required this.screen});
}

class _ToolCard extends StatelessWidget {
  final _ToolData tool;
  final VoidCallback onTap;

  const _ToolCard({required this.tool, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.gray200, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: tool.color.withOpacity(0.1), borderRadius: BorderRadius.circular(AppRadius.md)),
                child: Icon(tool.icon, color: tool.color, size: 24),
              ),
              const Spacer(),
              Text(tool.title, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            // Profile Header
            Container(
              width: 96, height: 96,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: const Icon(Icons.person, size: 48, color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(authService.user?.userMetadata?['full_name'] ?? 'User', style: Theme.of(context).textTheme.headlineSmall),
            Text(authService.user?.email ?? '', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.xl),

            // Settings Cards
            _SettingsCard(
              children: [
                _SettingsTile(icon: Icons.brightness_6, title: 'Theme', trailing: const ThemeSelectorWidget()),
                _SettingsTile(icon: Icons.notifications_outlined, title: 'Notifications', onTap: () {}),
                _SettingsTile(icon: Icons.language, title: 'Language', trailing: const Text('English')),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            _SettingsCard(
              children: [
                _SettingsTile(icon: Icons.help_outline, title: 'Help & Support', onTap: () {}),
                _SettingsTile(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy', onTap: () {}),
                _SettingsTile(icon: Icons.info_outline, title: 'About', trailing: const Text('v1.0.0')),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async => await authService.signOut(),
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.gray200, width: 1),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({required this.icon, required this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right, color: AppColors.textSecondary) : null),
      onTap: onTap,
    );
  }
}
