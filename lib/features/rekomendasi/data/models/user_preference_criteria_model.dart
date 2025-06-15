import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/user_preference_criteria.dart';

class UserPreferenceCriteriaModel extends UserPreferenceCriteria {
  const UserPreferenceCriteriaModel({
    required super.criteria_id,
    required super.weight,
  });

  factory UserPreferenceCriteriaModel.fromJson(Map<String, dynamic> json) {
    return UserPreferenceCriteriaModel(
      criteria_id: json['criteria_id'],
      weight:
          (json['weight'] as num).toDouble(), // Pastikan weight selalu double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'criteria_id': criteria_id,
      'weight': weight,
    };
  }

  static List<UserPreferenceCriteriaModel> fromJsonList(List<dynamic> data) {
    if (data.isEmpty) return [];
    return data
        .map((singleData) => UserPreferenceCriteriaModel.fromJson(singleData))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<UserPreferenceCriteriaModel> data) {
    if (data.isEmpty) return [];
    return data.map((singleData) => singleData.toJson()).toList();
  }
}
