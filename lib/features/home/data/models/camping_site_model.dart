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
  @override
  final String link;
  @override
  final int reviews;
  @override
  final String phone;
  @override
  final String location;

  const CampingSiteModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.locationId,
    required this.rating,
    required this.link,
    required this.reviews,
    required this.phone,
    required this.location,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          locationId: locationId,
          rating: rating,
          link: link,
          reviews: reviews,
          phone: phone,
          location: location,
        );

  factory CampingSiteModel.fromJson(Map<String, dynamic> json) {
    return CampingSiteModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown",
      imageUrl: json['image_url'] ?? "",
      locationId: json['location_id'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Ubah ke double,
      link: json['link'] ?? "",
      reviews: json['reviews'] ?? 0,
      phone: json['phone'] ?? "",
      location: json['location'] ?? "Unknown",
    );
  }

  static List<CampingSiteModel?> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      try {
        return CampingSiteModel.fromJson(json);
      } catch (e) {
        print("Error parsing list: $e");
        return null; // Tetap tambahkan null jika ada error
      }
    }).toList(); // Jangan hapus item yang null
  }
}
