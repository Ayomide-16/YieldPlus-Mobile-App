import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/environment.dart';
import 'core/theme/app_theme.dart';
import 'services/auth_service.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/landing_screen.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  runApp(const YieldPlusApp());
}

class YieldPlusApp extends StatelessWidget {
  const YieldPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer2<AuthService, ThemeProvider>(
        builder: (context, authService, themeProvider, _) {
          return MaterialApp(
            title: 'YieldPlus.AI',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.flutterThemeMode,
            home: authService.isAuthenticated
                ? const HomeScreen()
                : const LandingScreen(),
          );
        },
      ),
    );
  }
}
