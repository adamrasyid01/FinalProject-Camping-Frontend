import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  final String id;
  final String email;
  final String name;
  final String password;

  @override
  List<Object> get props => [id, email, name, password];
}