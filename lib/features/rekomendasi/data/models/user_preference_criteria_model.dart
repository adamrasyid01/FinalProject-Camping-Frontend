import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/user_preference_criteria.dart';

class UserPreferenceCriteriaModel extends UserPreferenceCriteria {
  UserPreferenceCriteriaModel({
    required int id,
    required int user_preference_id,
    required int criteria_id,
    required double weight,
  }) : super(
          id: id,
          user_preference_id: user_preference_id,
          criteria_id: criteria_id,
          weight: weight,
        );

  // Factory constructor untuk membuat instance dari JSON
  factory UserPreferenceCriteriaModel.fromJson(Map<String, dynamic> json) {
    return UserPreferenceCriteriaModel(
      id: json['id'],
      user_preference_id: json['user_preference_id'],
      criteria_id: json['criteria_id'],
      weight: json['weight'],
    );
  }

  // Konversi instance ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_preference_id': user_preference_id,
      'criteria_id': criteria_id,
      'weight': weight,
    };
  }

  // Konversi list dari JSON ke list model
  static List<UserPreferenceCriteriaModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data
        .map((singleData) => UserPreferenceCriteriaModel.fromJson(singleData))
        .toList();
  }

  // Konversi list ke JSON
  static List<Map<String, dynamic>> toJsonList(
      List<UserPreferenceCriteriaModel> data) {
    if (data.isEmpty) return [];
    return data.map((singleData) => singleData.toJson()).toList();
  }
}
