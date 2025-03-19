import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

class Bookmark extends Equatable {
  final int id;
  final int userId;
  final int campingSite;

  Bookmark({
    required this.id,
    required this.userId,
    required this.campingSite,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, campingSite];
}
