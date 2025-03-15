import 'dart:convert';

import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<List<Map<String, dynamic>>> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString("user_preferences");

    if (encodedData != null) {
      List<dynamic> decodedList = jsonDecode(encodedData);
      List<UserPreferenceCriteriaModel> savedPreferences = decodedList
          .map((e) => UserPreferenceCriteriaModel.fromJson(e))
          .toList();

      return savedPreferences
          .map((pref) => {
                'name': _getCriteriaName(pref.criteria_id),
                'weight': pref.weight
              })
          .toList();
    }

    // Jika tidak ada data, kembalikan default
    return [
      {'name': 'Keamanan', 'weight': 9.0},
      {'name': 'Kenyamanan', 'weight': 7.0},
      {'name': 'Kebersihan', 'weight': 5.0},
      {'name': 'Kemudahan Transportasi', 'weight': 3.0},
    ];
  }

  String _getCriteriaName(int criteriaId) {
    switch (criteriaId) {
      case 1:
        return 'Keamanan';
      case 2:
        return 'Kenyamanan';
      case 3:
        return 'Kebersihan';
      case 4:
        return 'Kemudahan Transportasi';
      default:
        return 'Unknown';
    }
  }
}
