import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_site.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCampingLocation getCampingLocation;
  final GetCampingSite getCampingSite;

  HomeBloc({
    required this.getCampingLocation,
    required this.getCampingSite,
  }) : super(HomeStateInitial()) {
    // Get Camping Locations
    on<HomeEventGetCampingLocations>((event, emit) async {
      emit(HomeStateLoading());
      final result = await getCampingLocation.execute(filter: event.filter);
      result.fold(
        (failure) => emit(HomeStateError(failure.message)),
        (locations) => emit(HomeStateSuccessCampingLocation(locations)),
      );
    });

    // Get Camping Sites
    on<HomeEventGetCampingSite>((event, emit) async {
      emit(HomeStateLoading());
      final result =
          await getCampingSite.execute(event.locationId, search: event.search);

      result.fold(
        (failure) => emit(HomeStateError(failure.message)),
        (sites) => emit(HomeStateSuccessCampingSite(sites)),
      );
    });
  }
}
