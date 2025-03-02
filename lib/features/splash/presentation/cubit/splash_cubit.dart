import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/splash/domain/usecases/check_user_loggedin.dart';
import 'package:dartz/dartz.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckUserLoggedin checkUserLoggedin;

  SplashCubit({required this.checkUserLoggedin}) : super(SplashInitial());

  Future<Either<Failure, void>> checkUserLoggedIn() async {
    emit(SplashStateLoading());

    final result = await checkUserLoggedin.execute();

    result.fold(
      (failure) =>
          emit(SplashStateNotLoggedIn("Terjadi kesalahan")), // Jika gagal
      (isLoggedIn) async {
        await Future.delayed(Duration(seconds: 1));
        emit(SplashStateLoggedIn("Login Berhasil")); // Jika berhasil
      },
    );
      return result;
  }
}
