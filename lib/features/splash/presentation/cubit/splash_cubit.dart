import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/splash/domain/repositories/splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository splashRepository;

  SplashCubit({required this.splashRepository}) : super(SplashInitial());

  Future<void> checkUserLoggedIn() async {
    emit(SplashStateLoading());

    // await Future.delayed(Duration(seconds: 2)); // Tambahkan delay di sini

    final result = await splashRepository.checkUserLoggedin();

    result.fold(
      (failure) => emit(SplashStateNotLoggedIn("Error")), // Jika gagal
      (isLoggedIn) async {
        await Future.delayed(Duration(seconds: 1));

        if (isLoggedIn) {
          emit(SplashStateLoggedIn("Success")); // Jika user sudah login
        } else {
          emit(SplashStateNotLoggedIn("Error")); // Jika user belum login
        }
      },
    );
  }
}
