import 'supabase_service.dart';

/// Service for calling AI-powered Edge Functions
class EdgeFunctionService {
  /// Analyze soil conditions
  static Future<Map<String, dynamic>> analyzeSoil({
    required String color,
    required String texture,
    String? notes,
    String? imageBase64,
    String? soilPH,
    String? soilCompactness,
  }) async {
    return await SupabaseService.callEdgeFunction('analyze-soil', {
      'color': color,
      'texture': texture,
      'notes': notes,
      'imageBase64': imageBase64,
      'soilPH': soilPH,
      'soilCompactness': soilCompactness,
    });
  }

  /// Identify pest or disease
  static Future<Map<String, dynamic>> identifyPest({
    required String cropType,
    required List<String> symptoms,
    required Map<String, dynamic> location,
  }) async {
    return await SupabaseService.callEdgeFunction('identify-pest', {
      'cropType': cropType,
      'symptoms': symptoms,
      'location': location,
    });
  }

  /// Analyze crop recommendations
  static Future<Map<String, dynamic>> analyzeCrop({
    required String cropName,
    required Map<String, dynamic> location,
    double? farmSize,
    String? soilType,
  }) async {
    return await SupabaseService.callEdgeFunction('analyze-crop', {
      'cropName': cropName,
      'location': location,
      'farmSize': farmSize,
      'soilType': soilType,
    });
  }

  /// Analyze fertilizer needs
  static Future<Map<String, dynamic>> analyzeFertilizer({
    required String cropType,
    required String soilType,
    required Map<String, dynamic> location,
    double? farmSize,
  }) async {
    return await SupabaseService.callEdgeFunction('analyze-fertilizer', {
      'cropType': cropType,
      'soilType': soilType,
      'location': location,
      'farmSize': farmSize,
    });
  }

  /// Analyze water usage
  static Future<Map<String, dynamic>> analyzeWater({
    required String cropType,
    required Map<String, dynamic> location,
    double? farmSize,
    String? irrigationType,
  }) async {
    return await SupabaseService.callEdgeFunction('analyze-water', {
      'cropType': cropType,
      'location': location,
      'farmSize': farmSize,
      'irrigationType': irrigationType,
    });
  }

  /// Estimate market price
  static Future<Map<String, dynamic>> estimateMarketPrice({
    required String cropName,
    required String state,
    double? quantity,
    String? unit,
  }) async {
    return await SupabaseService.callEdgeFunction('estimate-market-price', {
      'cropName': cropName,
      'state': state,
      'quantity': quantity,
      'unit': unit,
    });
  }

  /// Generate comprehensive farm plan
  static Future<Map<String, dynamic>> generateComprehensivePlan({
    required Map<String, dynamic> location,
    required double farmSize,
    required List<String> selectedCrops,
    String? soilType,
    String? budget,
  }) async {
    return await SupabaseService.callEdgeFunction('generate-comprehensive-plan', {
      'location': location,
      'farmSize': farmSize,
      'selectedCrops': selectedCrops,
      'soilType': soilType,
      'budget': budget,
    });
  }

  /// Get climate data for location
  static Future<Map<String, dynamic>> getClimateData({
    required Map<String, dynamic> location,
  }) async {
    return await SupabaseService.callEdgeFunction('get-climate-data', {
      'location': location,
    });
  }
}
