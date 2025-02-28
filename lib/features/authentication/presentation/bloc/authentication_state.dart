part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationStateInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}


class AuthenticationStateLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationStateError extends AuthenticationState {
  final String message;

  AuthenticationStateError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticationStateSuccess extends AuthenticationState {
  final User user;

  AuthenticationStateSuccess(this.user);

  @override
  List<Object> get props => [user];
}