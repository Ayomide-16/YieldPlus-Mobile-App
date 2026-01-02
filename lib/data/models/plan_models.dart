class SavedPlanModel {
  final String id;
  final String userId;
  final String planType;
  final String planName;
  final Map<String, dynamic> planData;
  final Map<String, dynamic>? location;
  final DateTime createdAt;

  SavedPlanModel({
    required this.id,
    required this.userId,
    required this.planType,
    required this.planName,
    required this.planData,
    this.location,
    required this.createdAt,
  });

  factory SavedPlanModel.fromJson(Map<String, dynamic> json) {
    return SavedPlanModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      planType: json['plan_type'] as String,
      planName: json['plan_name'] as String,
      planData: json['plan_data'] as Map<String, dynamic>,
      location: json['location'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'plan_type': planType,
      'plan_name': planName,
      'plan_data': planData,
      'location': location,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'user_id': userId,
      'plan_type': planType,
      'plan_name': planName,
      'plan_data': planData,
      'location': location,
    };
  }
}

class ComprehensivePlanModel {
  final String id;
  final String userId;
  final Map<String, dynamic> planData;
  final Map<String, dynamic>? location;
  final double? farmSize;
  final DateTime createdAt;

  ComprehensivePlanModel({
    required this.id,
    required this.userId,
    required this.planData,
    this.location,
    this.farmSize,
    required this.createdAt,
  });

  factory ComprehensivePlanModel.fromJson(Map<String, dynamic> json) {
    return ComprehensivePlanModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      planData: json['plan_data'] as Map<String, dynamic>,
      location: json['location'] as Map<String, dynamic>?,
      farmSize: json['farm_size'] != null ? (json['farm_size'] as num).toDouble() : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'plan_data': planData,
      'location': location,
      'farm_size': farmSize,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class MarketPriceModel {
  final String id;
  final String cropName;
  final String state;
  final String? marketName;
  final double price;
  final String unit;
  final String? source;
  final DateTime recordedAt;
  final DateTime createdAt;

  MarketPriceModel({
    required this.id,
    required this.cropName,
    required this.state,
    this.marketName,
    required this.price,
    this.unit = 'per kg',
    this.source,
    required this.recordedAt,
    required this.createdAt,
  });

  factory MarketPriceModel.fromJson(Map<String, dynamic> json) {
    return MarketPriceModel(
      id: json['id'] as String,
      cropName: json['crop_name'] as String,
      state: json['state'] as String,
      marketName: json['market_name'] as String?,
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] as String? ?? 'per kg',
      source: json['source'] as String?,
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class UserProfileModel {
  final String id;
  final String? fullName;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfileModel({
    required this.id,
    this.fullName,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
