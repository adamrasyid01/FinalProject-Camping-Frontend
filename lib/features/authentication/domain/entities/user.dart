import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final String password;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [id, email, name, password];
}
