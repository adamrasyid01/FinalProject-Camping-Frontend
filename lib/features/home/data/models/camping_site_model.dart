import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

class CampingSiteModel extends CampingSite {
  @override
  final int id;
  @override
  final String name;
  @override
  final int locationId;
  @override
  final String imageUrl;
  @override
  final double rating;

  const CampingSiteModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.locationId,
    required this.rating,
  
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          locationId: locationId,
          rating: rating,

        );

  factory CampingSiteModel.fromJson(Map<String, dynamic> json) {
    return CampingSiteModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      locationId: json['location_id'],
      rating: json['rating'],
    );
  }
  static List<CampingSiteModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data
        .map((singleData) => CampingSiteModel.fromJson(singleData))
        .toList();
  }
}
