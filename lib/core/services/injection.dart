import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/core/services/save_user.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';
import 'package:flutter_camping_frontend/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/authentication/data/repositories/user_repository_implementation.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/login.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/logout.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/usecases/register.dart';
import 'package:flutter_camping_frontend/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_camping_frontend/features/home/data/datasources/camping_location_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/home/data/datasources/camping_location_with_sites_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/home/data/datasources/camping_site_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/home/data/repositories/camping_location_repository_implementation.dart';
import 'package:flutter_camping_frontend/features/home/data/repositories/camping_location_with_sites_repo_impl.dart';
import 'package:flutter_camping_frontend/features/home/data/repositories/camping_site_repository_implementation.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location_with_sites.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_location_repository.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_location_with_sites_repository.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_site_repository.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location_with_sites.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_site.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/datasources/user_preference_criteria_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/repositories/user_preference_criteria_repository_implementation.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/repositories/user_preference_criteria_repository.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/usecases/save_user_preference_criteria.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/rekomendasi_bloc.dart';
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

  // TOKEN STORAGE SERVICE
  myInjection.registerLazySingleton<TokenStorage>(() => TokenStorage());

  // SERVICE - SAVE USER
  myInjection.registerLazySingleton<SaveUser>(() => SaveUser());

  // FEATURE - AUTH
  // BLOC
  myInjection.registerLazySingleton(() => AuthenticationBloc(
      login: myInjection(), logout: myInjection(), register: myInjection()));

  // USECASES
  myInjection.registerLazySingleton(() => Login(userRepository: myInjection()));
  myInjection
      .registerLazySingleton(() => Register(userRepository: myInjection()));
  myInjection
      .registerLazySingleton(() => Logout(userRepository: myInjection()));

  // Repository
  myInjection.registerLazySingleton<UserRepository>(
      () => UserRepositoryImplementation(userRemoteDataSource: myInjection()));
  // Datasource
  myInjection.registerLazySingleton<UserRemoteDataSource>(() =>
      UserRemoteDataSourceImplementation(
          dio: myInjection(),
          tokenStorage: myInjection(),
          saveUser: myInjection()));

  // FEATURE - SPLASH
  // BLOC
  myInjection.registerLazySingleton(
      () => SplashCubit(checkUserLoggedin: myInjection()));

  // USECASES
  myInjection.registerLazySingleton(
      () => CheckUserLoggedin(splashRepository: myInjection()));
  // Repository
  myInjection.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImplementation(tokenStorage: myInjection()));

  // FEATURE - HOME
  // CAMPING - LOCATION
  // BLOC
  myInjection.registerLazySingleton(() => HomeBloc(
      getCampingLocation: myInjection(),
      getCampingSite: myInjection(),
      getCampingLocationWithSites: myInjection()));
  // USECASES
  myInjection.registerLazySingleton(
      () => GetCampingLocation(campingLocationRepository: myInjection()));
  // Repository
  myInjection.registerLazySingleton<CampingLocationRepository>(() =>
      CampingLocationRepositoryImplementation(
          campingLocationDataSource: myInjection()));
  // Datasource
  myInjection.registerLazySingleton<CampingLocationRemoteDataSource>(
      () => CampingLocationRemoteDatasourceImplementation(dio: myInjection()));

  // CAMPING - SITES
  // USECASES
  myInjection.registerLazySingleton(
      () => GetCampingSite(campingSiteRepository: myInjection()));
  // Repository
  myInjection.registerLazySingleton<CampingSiteRepository>(() =>
      CampingSiteRepositoryImplementation(
          campingSiteRemoteDataSource: myInjection()));
  // Datasource
  myInjection.registerLazySingleton<CampingSiteRemoteDataSource>(
      () => CampingSiteRemoteDataSourceImplementation(dio: myInjection()));

  // CAMPING LOCATION WITH SITES
  // USECASES
  myInjection.registerLazySingleton(() =>
      GetCampingLocationWithSites(campingLocationWithSites: myInjection()));
  // Repository
  myInjection.registerLazySingleton<CampingLocationWithSitesRepository>(() =>
      CampingLocationWithSitesRepositoryImplementation(
          campingLocationWithSitesRemoteDataSource: myInjection()));
  // Datasource
  myInjection.registerLazySingleton<CampingLocationWithSitesRemoteDataSource>(
      () => CampingLocationWithSitesRemoteDataSourceImplementation(
          dio: myInjection()));

  // FEATURE - SAVE USERPREFERENCE CRITERIA
  // BLOC
  myInjection.registerLazySingleton(
      () => RekomendasiBloc(saveUserPreferenceCriteria: myInjection()));
  // USECASES
  myInjection.registerLazySingleton(() => SaveUserPreferenceCriteria(
      userPreferenceCriteriaRepository: myInjection()));
  // Repository
  myInjection.registerLazySingleton<UserPreferenceCriteriaRepository>(() =>
      UserPreferenceCriteriaRepositoryImplementation(
          userPreferenceCriteriaRemoteDatasource: myInjection()));
  // Datasource
  myInjection.registerLazySingleton<UserPreferenceCriteriaRemoteDatasource>(
      () => UserPreferenceCriteriaRemoteDataSourceImplementation(
          dio: myInjection()));
}
