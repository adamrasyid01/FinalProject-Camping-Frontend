import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['passwordConfirmation'],
    );
  }
}
