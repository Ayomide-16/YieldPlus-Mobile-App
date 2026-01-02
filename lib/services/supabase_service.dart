import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  // Getter for current user
  static User? get currentUser => client.auth.currentUser;

  // Check if user is authenticated
  static bool get isAuthenticated => currentUser != null;

  // Auth methods
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: fullName != null ? {'full_name': fullName} : null,
    );
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  // Database methods
  static SupabaseQueryBuilder from(String table) {
    return client.from(table);
  }

  // Real-time subscription
  static RealtimeChannel subscribeToTable(
    String table,
    void Function(PostgresChangePayload) callback,
  ) {
    return client
        .channel('public:\')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: table,
          callback: callback,
        )
        .subscribe();
  }

  // Storage methods
  static SupabaseStorageClient get storage => client.storage;

  static Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
  }) async {
    await storage.from(bucket).upload(path, file);
    return storage.from(bucket).getPublicUrl(path);
  }

  static Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    await storage.from(bucket).remove([path]);
  }

  // Edge Function calls
  static Future<Map<String, dynamic>> callEdgeFunction(
    String functionName,
    Map<String, dynamic> body,
  ) async {
    final response = await client.functions.invoke(
      functionName,
      body: body,
    );

    if (response.status != 200) {
      throw Exception('Edge function error: \');
    }

    return response.data as Map<String, dynamic>;
  }
}

