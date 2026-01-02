import '../models/farm_model.dart';
import '../../services/supabase_service.dart';

class FarmRepository {
  static const String _tableName = 'farms';

  // Get all farms for current user
  Future<List<FarmModel>> getFarms() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final response = await SupabaseService.from(_tableName)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => FarmModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Get single farm by ID
  Future<FarmModel> getFarm(String farmId) async {
    final response = await SupabaseService.from(_tableName)
        .select()
        .eq('id', farmId)
        .single();

    return FarmModel.fromJson(response);
  }

  // Create new farm
  Future<FarmModel> createFarm({
    required String name,
    Map<String, dynamic>? location,
    double? size,
    String? sizeUnit,
    String? soilType,
    List<String>? crops,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final data = {
      'user_id': userId,
      'name': name,
      'location': location,
      'size': size,
      'size_unit': sizeUnit ?? 'hectares',
      'soil_type': soilType,
      'crops': crops,
    };

    final response = await SupabaseService.from(_tableName)
        .insert(data)
        .select()
        .single();

    return FarmModel.fromJson(response);
  }

  // Update farm
  Future<FarmModel> updateFarm(String farmId, Map<String, dynamic> updates) async {
    updates['updated_at'] = DateTime.now().toIso8601String();

    final response = await SupabaseService.from(_tableName)
        .update(updates)
        .eq('id', farmId)
        .select()
        .single();

    return FarmModel.fromJson(response);
  }

  // Delete farm
  Future<void> deleteFarm(String farmId) async {
    await SupabaseService.from(_tableName).delete().eq('id', farmId);
  }
}
