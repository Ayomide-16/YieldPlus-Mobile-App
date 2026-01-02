import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class ThemeSelectorWidget extends StatelessWidget {
  const ThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return PopupMenuButton<AppThemeMode>(
      icon: Icon(themeProvider.themeIcon),
      tooltip: 'Change Theme',
      onSelected: (mode) => themeProvider.setThemeMode(mode),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: AppThemeMode.light,
          child: Row(
            children: [
              Icon(Icons.light_mode, color: themeProvider.themeMode == AppThemeMode.light ? Theme.of(context).primaryColor : null),
              const SizedBox(width: 12),
              const Text('Light'),
              if (themeProvider.themeMode == AppThemeMode.light) ...[
                const Spacer(),
                const Icon(Icons.check, size: 18),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: AppThemeMode.dark,
          child: Row(
            children: [
              Icon(Icons.dark_mode, color: themeProvider.themeMode == AppThemeMode.dark ? Theme.of(context).primaryColor : null),
              const SizedBox(width: 12),
              const Text('Dark'),
              if (themeProvider.themeMode == AppThemeMode.dark) ...[
                const Spacer(),
                const Icon(Icons.check, size: 18),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: AppThemeMode.system,
          child: Row(
            children: [
              Icon(Icons.brightness_auto, color: themeProvider.themeMode == AppThemeMode.system ? Theme.of(context).primaryColor : null),
              const SizedBox(width: 12),
              const Text('System'),
              if (themeProvider.themeMode == AppThemeMode.system) ...[
                const Spacer(),
                const Icon(Icons.check, size: 18),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
