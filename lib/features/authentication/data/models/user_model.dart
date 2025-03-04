import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  final int id;
  final String name;
  final String email;
  final String? profilePhotoUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhotoUrl,
  }) : super(
          id: id,
          name: name,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
}
