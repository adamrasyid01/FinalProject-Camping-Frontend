import 'package:equatable/equatable.dart';

class CampingSite extends Equatable {
  final int id;
  final String name;
  final int locationId;
  final String imageUrl;
  final double rating;
  final String link;
  final int reviews;
  final String phone;
  final String location;

  const CampingSite({
    required this.id,
    required this.name,
    required this.locationId,
    required this.imageUrl,
    required this.rating,
    required this.link,
    required this.reviews,
    required this.phone,
    required this.location,
  });

  @override
  List<Object> get props => [id, name, locationId, imageUrl, rating, link, reviews, phone, location];
}
