class Environment {
  // Supabase Configuration (same as web app)
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://ptrkvdkxbwwzszwuweja.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0cmt2ZGt4Ynd3enN6d3V3ZWphIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA3NDQ5NzEsImV4cCI6MjA3NjMyMDk3MX0.z0N0nokoeYdKQSrthJMIesJYxXCakkz0ObabghHLaoU',
  );

  // App Configuration
  static const bool isProduction = bool.fromEnvironment(
    'IS_PRODUCTION',
    defaultValue: false,
  );

  static const String appName = 'YieldPlus';
  static const String appVersion = '1.0.0';
}
