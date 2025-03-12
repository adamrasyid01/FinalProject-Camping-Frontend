import 'dart:convert';

import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPreference {
  double? keamanan;
  double? kenyamanan;
  double? kebersihan;
  double? kemudahanTransportasi;

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString("user_preferences");

    if (encodedData != null) {
      List<dynamic> decodedList = jsonDecode(encodedData);
      List<UserPreferenceCriteriaModel> savedPreferences = decodedList
          .map((e) => UserPreferenceCriteriaModel.fromJson(e))
          .toList();

      keamanan = savedPreferences[0].weight;
      kenyamanan = savedPreferences[1].weight;
      kebersihan = savedPreferences[2].weight;
      kemudahanTransportasi = savedPreferences[3].weight;
    }
  }
}
