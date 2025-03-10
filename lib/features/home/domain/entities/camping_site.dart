import 'package:equatable/equatable.dart';

class CampingSite extends Equatable {
  final int id;
  final String name;
  final int locationId;
  final String imageUrl;
  final double rating;

  const CampingSite({
    required this.id,
    required this.name,
    required this.locationId,
    required this.imageUrl,
    required this.rating,
  });

  @override
  List<Object> get props => [id, name, locationId, imageUrl, rating];
}
