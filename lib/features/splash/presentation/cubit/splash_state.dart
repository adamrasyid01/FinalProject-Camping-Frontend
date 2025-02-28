part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {}

class SplashInitial extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashStateLoading extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashStateNotLoggedIn extends SplashState {
  final String message;
  SplashStateNotLoggedIn(this.message);
  @override
  List<Object?> get props => [];
}

class SplashStateLoggedIn extends SplashState {
  final String message;
  SplashStateLoggedIn(this.message);
  @override
  List<Object?> get props => [];
}
