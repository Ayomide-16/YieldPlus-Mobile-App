import '../models/plan_models.dart';
import '../../services/supabase_service.dart';

class PlanRepository {
  // Get saved plans for current user
  Future<List<SavedPlanModel>> getSavedPlans({String? planType}) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    var query = SupabaseService.from('saved_plans')
        .select()
        .eq('user_id', userId);

    if (planType != null) {
      query = query.eq('plan_type', planType);
    }

    final response = await query.order('created_at', ascending: false);

    return (response as List)
        .map((json) => SavedPlanModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Create saved plan
  Future<SavedPlanModel> createSavedPlan({
    required String planType,
    required String planName,
    required Map<String, dynamic> planData,
    Map<String, dynamic>? location,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final data = {
      'user_id': userId,
      'plan_type': planType,
      'plan_name': planName,
      'plan_data': planData,
      'location': location,
    };

    final response = await SupabaseService.from('saved_plans')
        .insert(data)
        .select()
        .single();

    return SavedPlanModel.fromJson(response);
  }

  // Delete saved plan
  Future<void> deleteSavedPlan(String planId) async {
    await SupabaseService.from('saved_plans').delete().eq('id', planId);
  }

  // Get comprehensive plans
  Future<List<ComprehensivePlanModel>> getComprehensivePlans() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final response = await SupabaseService.from('comprehensive_plans')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ComprehensivePlanModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Get market prices
  Future<List<MarketPriceModel>> getMarketPrices({String? cropName, String? state}) async {
    var query = SupabaseService.from('market_prices').select();

    if (cropName != null) {
      query = query.ilike('crop_name', '%\%');
    }
    if (state != null) {
      query = query.eq('state', state);
    }

    final response = await query.order('recorded_at', ascending: false).limit(100);

    return (response as List)
        .map((json) => MarketPriceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Get user profile
  Future<UserProfileModel?> getUserProfile() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return null;

    try {
      final response = await SupabaseService.from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return UserProfileModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Update user profile
  Future<UserProfileModel> updateUserProfile({
    String? fullName,
    String? avatarUrl,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (fullName != null) updates['full_name'] = fullName;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;

    final response = await SupabaseService.from('profiles')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserProfileModel.fromJson(response);
  }
}
