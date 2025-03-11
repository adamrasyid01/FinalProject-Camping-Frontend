import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location_with_sites.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';

class CampingLocationWithSitesModel extends CampingLocationWithSites {
  const CampingLocationWithSitesModel({
    required super.locationName,
    required super.campingSites,
  });

  factory CampingLocationWithSitesModel.fromJson(Map<String, dynamic> json) {
    return CampingLocationWithSitesModel(
      locationName: json['name'], // Sesuaikan dengan respons API
      campingSites: (json['camping_sites'] as List)
          .map((site) => CampingSiteModel.fromJson(site))
          .toList(),
    );
  }
}
