import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final String? profilePhotoUrl;
  final String token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhotoUrl,
    required this.token
  });

  @override
  List<Object> get props => [id, email, name, profilePhotoUrl ?? '', token];
}
