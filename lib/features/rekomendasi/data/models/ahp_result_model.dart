import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';

class AHPResultModel extends AHPResult {
  AHPResultModel({
    required int camping_site_id,
    required double final_score,
    required CampingSiteModel campingSite,
  }) : super(
          camping_site_id: camping_site_id,
          final_score: final_score,
          campingSite: campingSite,
        );

  factory AHPResultModel.fromJson(Map<String, dynamic> json) {
    return AHPResultModel(
      camping_site_id: json['camping_site_id'],
      final_score: json['final_score'].toDouble(),
      campingSite: CampingSiteModel.fromJson(json['camping_site']),
    );
  }

  static List<AHPResultModel?> fromJsonList(List<dynamic> data) {
    return data.map((singleData) {
      try {
        return AHPResultModel.fromJson(singleData);
      } catch (e) {
        print('Error parsing AHPResultModel: $e');
        return null; // Return null if parsing fails
      }
    }).toList();
  }
}
