import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/get_current_user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/login.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/logout.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/register.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetCurrentUser getCurrentUser;
  final Login login;
  final Logout logout;
  final Register register;

  AuthenticationBloc({
    required this.getCurrentUser,
    required this.login,
    required this.logout,
    required this.register,
  }) : super(AuthenticationStateInitial()) {
    on<AuthenticationEventLogin>((event, emit) async {
      emit(AuthenticationStateLoading());
      Either<Failure, User> result = await login.execute(event.email, event.password,);
      result.fold(
        (failure) => emit(AuthenticationStateError("Error")),
        (success) => emit(AuthenticationStateSuccess(success)),
      )
;   });
    on<AuthenticationEventGetCurrentUser>((event, emit) async {
      emit(AuthenticationStateLoading());
      Either<Failure, User> result = await getCurrentUser.execute();
      result.fold(
        (failure) => emit(AuthenticationStateError("Error")),
        (success) => emit(AuthenticationStateSuccess(success)),
      )
;   });
    on<AuthenticationEventLogout>((event, emit) async {
      emit(AuthenticationStateLoading());
      Either<Failure, void> result = await logout.execute();
      result.fold(
        (failure) => emit(AuthenticationStateError("Error")),
        (_) => emit(AuthenticationStateInitial()),
      )
;   });
    on<AuthenticationEventRegister>((event, emit) async {
      emit(AuthenticationStateLoading());
      Either<Failure, User> result = await register.execute(event.name, event.email, event.password,);
      result.fold(
        (failure) => emit(AuthenticationStateError("Error")),
        (success) => emit(AuthenticationStateSuccess(success)),
      )
;   });
  }
}
