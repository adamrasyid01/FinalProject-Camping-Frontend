import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';

class AHPResultModel extends AHPResult {
  const AHPResultModel({
    required super.camping_site_id,
    required super.final_score,
    required CampingSiteModel super.campingSite,
  });

  factory AHPResultModel.fromJson(Map<String, dynamic> json) {
    return AHPResultModel(
      camping_site_id: json['camping_site_id'],
      final_score: json['final_score'].toDouble(),
      campingSite: CampingSiteModel.fromJson(json['camping_site']),
    );
  }

  static List<AHPResultModel> fromJsonList(List data) {
    if(data.isEmpty) return [];
    return data.map((singleData) => AHPResultModel.fromJson(singleData)).toList();
  }

   
}
