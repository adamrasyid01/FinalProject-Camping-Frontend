import 'package:equatable/equatable.dart';

class CampingLocation extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int totalCamps;
  

  const CampingLocation(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.totalCamps});

  @override
  List<Object?> get props => [id, name, imageUrl, totalCamps];
}
