import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [id, email, name, password, passwordConfirmation];
}
