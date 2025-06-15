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
  final int total_reviews;
  @override
  final String location;
  @override
  final String phone;
  @override
  final List<Map<String, String>> text_reviews;
  @override
  final List<Map<String, String>> total_sentimen;

  const CampingSiteModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.locationId,
    required this.rating,
    required this.link,
    required this.total_reviews,
    required this.phone,
    required this.location,
    required this.text_reviews,
    required this.total_sentimen,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          locationId: locationId,
          rating: rating,
          link: link,
          total_reviews: total_reviews,
          phone: phone,
          location: location,
          text_reviews: text_reviews,
          total_sentimen: total_sentimen,
        );

  factory CampingSiteModel.fromJson(Map<String, dynamic> json) {
    return CampingSiteModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "Unknown",
        imageUrl: json['image_url'] ?? "",
        locationId: json['location_id'] ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        link: json['link'] ?? "",
        total_reviews: json['reviews'] ?? 0,
        phone: json['phone'] ?? "",
        location: json['location'] ?? "Unknown",

        // Parsing List<Map<String, String>> dari JSON (array of objects)
        text_reviews: (json['text_reviews'] as List<dynamic>)
            .map((e) => {
                  "text": (e['text'] ?? "").toString(),
                })
            .toList(),
        total_sentimen: (json['total_sentimen'] as List<dynamic>)
            .map((e) => {
                  "criterion_id": e['criterion_id'].toString(),
                  "total_positif": e['total_positif'].toString(),
                  "total_netral": e['total_netral'].toString(),
                  "total_negatif": e['total_negatif'].toString(),
                })
            .toList());
  }

  static List<CampingSiteModel> fromJsonList(List jsonList) {
    // return jsonList.map((json) {
    //   try {
    //     return CampingSiteModel.fromJson(json);
    //   } catch (e) {
    //     print("Error parsing list: $e");
    //     return null; // Tetap tambahkan null jika ada error
    //   }
    // }).toList(); // Jangan hapus item yang null

    if (jsonList.isEmpty) return [];
    return jsonList.map((item) => CampingSiteModel.fromJson(item)).toList();
  }
}
