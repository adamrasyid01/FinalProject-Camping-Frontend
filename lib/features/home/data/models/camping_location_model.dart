import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';

class CampingLocationModel extends CampingLocation {
  final int id;
  final String name;
  final String imageUrl;
  final int totalCamps;

  const CampingLocationModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.totalCamps,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          totalCamps: totalCamps,
        );

  factory CampingLocationModel.fromJson(Map<String, dynamic> json) {
    return CampingLocationModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      totalCamps: json['total_camps'],
    );
  }
  static List<CampingLocationModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data
        .map((singleData) => CampingLocationModel.fromJson(singleData))
        .toList();
  }
}
