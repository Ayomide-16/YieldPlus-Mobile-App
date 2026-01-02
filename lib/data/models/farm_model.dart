class FarmModel {
  final String id;
  final String userId;
  final String name;
  final Map<String, dynamic>? location;
  final double? size;
  final String sizeUnit;
  final String? soilType;
  final List<String>? crops;
  final DateTime createdAt;
  final DateTime updatedAt;

  FarmModel({
    required this.id,
    required this.userId,
    required this.name,
    this.location,
    this.size,
    this.sizeUnit = 'hectares',
    this.soilType,
    this.crops,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      location: json['location'] as Map<String, dynamic>?,
      size: json['size'] != null ? (json['size'] as num).toDouble() : null,
      sizeUnit: json['size_unit'] as String? ?? 'hectares',
      soilType: json['soil_type'] as String?,
      crops: json['crops'] != null 
          ? List<String>.from(json['crops'] as List) 
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'location': location,
      'size': size,
      'size_unit': sizeUnit,
      'soil_type': soilType,
      'crops': crops,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'user_id': userId,
      'name': name,
      'location': location,
      'size': size,
      'size_unit': sizeUnit,
      'soil_type': soilType,
      'crops': crops,
    };
  }

  FarmModel copyWith({
    String? id,
    String? userId,
    String? name,
    Map<String, dynamic>? location,
    double? size,
    String? sizeUnit,
    String? soilType,
    List<String>? crops,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FarmModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      location: location ?? this.location,
      size: size ?? this.size,
      sizeUnit: sizeUnit ?? this.sizeUnit,
      soilType: soilType ?? this.soilType,
      crops: crops ?? this.crops,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper getters for location
  String? get country => location?['country'] as String?;
  String? get state => location?['state'] as String?;
  String? get localGovernment => location?['localGovernment'] as String?;
}
