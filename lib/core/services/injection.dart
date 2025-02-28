import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/authentication/data/repositories/user_repository_implementation.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/get_current_user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/login.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/logout.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/register.dart';
import 'package:flutter_camping_frontend/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_camping_frontend/features/splash/data/repositories/splash_repository_implementation.dart';
import 'package:flutter_camping_frontend/features/splash/domain/repositories/splash_repository.dart';
import 'package:flutter_camping_frontend/features/splash/domain/usecases/check_user_loggedin.dart';
import 'package:flutter_camping_frontend/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Penampungan dependency injection
var myInjection = GetIt.instance;

Future<void> init() async {
//  GENERAL

  // DIO
  myInjection.registerFactory<DioClient>(() => DioClient());
  // SHARED PREFERENCES
  final sharedPreferences = await SharedPreferences.getInstance();
  myInjection.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // FEATURE - AUTH
  // BLOC
  myInjection.registerLazySingleton(() => AuthenticationBloc(
      getCurrentUser: myInjection(),
      login: myInjection(),
      logout: myInjection(),
      register: myInjection()));

  // REPOSITORY
  myInjection.registerLazySingleton(() => Login(userRepository: myInjection()));
  myInjection
      .registerLazySingleton(() => Register(userRepository: myInjection()));
  myInjection
      .registerLazySingleton(() => Logout(userRepository: myInjection()));
  myInjection.registerLazySingleton(
      () => GetCurrentUser(userRepository: myInjection()));

  // Datasource
  myInjection.registerLazySingleton<UserRepository>(
      () => UserRepositoryImplementation(userRemoteDataSource: myInjection()));

  // FEATURE - SPLASH
  // BLOC
  myInjection.registerLazySingleton(
      () => SplashCubit(splashRepository: myInjection()));
  // Repository
  myInjection.registerLazySingleton(
      () => CheckUserLoggedin(splashRepository: myInjection()));
  // Datasource
  myInjection.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImplementation());
}
