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
  final List<Map<String, dynamic>> text_reviews;
  @override
  final List<Map<String, dynamic>> total_sentimen;

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

  // --- FUNGSI FROMJSON YANG DIPERBAIKI ---
  factory CampingSiteModel.fromJson(Map<String, dynamic> json) {
    // Parsing List yang aman
    final List<Map<String, dynamic>> textReviewsList =
        (json['text_reviews'] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ?? // Jika null, kembalikan list kosong
            [];

    final List<Map<String, dynamic>> totalSentimenList =
        (json['total_sentimen'] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ?? // Jika null, kembalikan list kosong
            [];

    return CampingSiteModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "Unknown",
      imageUrl: json['image_url'] as String? ?? "",
      locationId: json['location_id'] as int? ?? 0,
      // Parsing angka yang aman (menerima int atau double)
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      link: json['link'] as String? ?? "",
      // KESALAHAN 1: Menggunakan nama kunci yang benar
      total_reviews: json['total_reviews'] as int? ?? 0,
      // Beri nilai default jika 'phone' tidak ada di JSON
      phone: json['phone'] as String? ?? "No Phone",
      location: json['location'] as String? ?? "Unknown",

      // Gunakan list yang sudah diparsing dengan aman
      text_reviews: textReviewsList,
      total_sentimen: totalSentimenList,
    );
  }

  static List<CampingSiteModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    // Bungkus dengan try-catch untuk menangani jika ada satu item yang gagal parsing
    return jsonList
        .map((item) {
          try {
            return CampingSiteModel.fromJson(item);
          } catch (e) {
            print("Error parsing item: $item. Error: $e");
            // Mengembalikan null atau model default bisa jadi pilihan,
            // tapi melempar error agar tahu ada data yang salah juga baik.
            // Di sini kita lewati saja item yang error.
            return null;
          }
        })
        .where((item) => item != null)
        .cast<CampingSiteModel>()
        .toList();
  }
}
