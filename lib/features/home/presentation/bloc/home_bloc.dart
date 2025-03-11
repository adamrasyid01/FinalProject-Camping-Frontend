import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location_with_sites.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location_with_sites.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_site.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCampingLocation getCampingLocation;
  final GetCampingSite getCampingSite;
  final GetCampingLocationWithSites getCampingLocationWithSites;

  HomeBloc({
    required this.getCampingLocation,
    required this.getCampingSite,
    required this.getCampingLocationWithSites,
  }) : super(HomeStateInitial()) {
    // Get Camping Locations
    on<HomeEventGetCampingLocations>((event, emit) async {
      emit(HomeStateLoading());
      final result = await getCampingLocation.execute();
      result.fold(
        (failure) => emit(HomeStateError(failure.message)),
        (locations) => emit(HomeStateSuccessCampingLocation(locations)),
      );
    });

    // Get Camping Sites
    on<HomeEventGetCampingSite>((event, emit) async {
      emit(HomeStateLoading());
      final result = await getCampingSite.execute(event.locationId);
      result.fold(
        (failure) => emit(HomeStateError(failure.message)),
        (sites) => emit(HomeStateSuccessCampingSite(sites)),
      );
    });

    // Get Camping Locations with Sites
    on<HomeEventGetCampingLocationWithSites>((event, emit) async {
      emit(HomeStateLoading());
      final result =
          await getCampingLocationWithSites.execute(event.locationId);
      result.fold(
        (failure) => emit(HomeStateError(failure.message)),
        (locationsWithSites) =>
            emit(HomeStateSuccessCampingLocationWithSites(locationsWithSites)),
      );
    });
  }
}
