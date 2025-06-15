import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final int id;
  final int userId;
  final int campingSite;

  const Bookmark({
    required this.id,
    required this.userId,
    required this.campingSite,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, campingSite];
}
