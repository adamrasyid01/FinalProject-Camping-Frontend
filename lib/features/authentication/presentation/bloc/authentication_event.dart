part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationEventGetCurrentUser extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationEventLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthenticationEventLogout extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationEventRegister extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  AuthenticationEventRegister(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirmation});

  @override
  List<Object> get props => [name, email, password];
}
