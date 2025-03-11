import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

class CampingLocationWithSites {
  final String locationName;
  final List<CampingSite> campingSites;

  const CampingLocationWithSites({
    required this.locationName,
    required this.campingSites,
  });
}
