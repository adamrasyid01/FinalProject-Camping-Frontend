import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';

class AHPResultModel extends AHPResult {
  const AHPResultModel({
    required super.camping_site_id,
    required super.final_score,
    required CampingSiteModel super.campingSite,
  });

  factory AHPResultModel.fromJson(Map<String, dynamic> json) {
    // Anda bisa menambahkan print di sini untuk debugging
    // print("Mencoba parsing data dengan camping_site_id: ${json['camping_site_id']}");
    // print("Nilai dari 'camping_site': ${json['camping_site']}");

    return AHPResultModel(
      camping_site_id: json['camping_site_id'],
      final_score: json['final_score'],

      // INI PERBAIKANNYA: Cek null sebelum parsing
      campingSite: json['camping_site'] != null && json['camping_site'] is Map
          ? CampingSiteModel.fromJson(json['camping_site'])
          : CampingSiteModel.empty(), // Jika null, gunakan model kosong
    );
  }

  static List<AHPResultModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data
        .map((singleData) => AHPResultModel.fromJson(singleData))
        .toList();
  }
}
