import 'package:equatable/equatable.dart';

class CampingSite extends Equatable {
  final int id;
  final String name;
  final int locationId;
  final String imageUrl;
  final double rating;
  final String link;
  final int total_reviews;
  final String location;
  final String phone;
  final List<Map<String, dynamic>> text_reviews;
  final List<Map<String, dynamic>> total_sentimen;

  const CampingSite({
    required this.id,
    required this.name,
    required this.locationId,
    required this.imageUrl,
    required this.rating,
    required this.link,
    required this.total_reviews,
    required this.location,
    required this.phone,
    required this.text_reviews,
    required this.total_sentimen,
  });

  @override
  List<Object> get props => [id, name, locationId, imageUrl, rating, link, total_reviews, location, phone, text_reviews, total_sentimen];
}

