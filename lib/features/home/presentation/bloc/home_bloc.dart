import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_site.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
 final GetCampingLocation getCampingLocation;
 final GetCampingSite getCampingSite;
  HomeBloc({required this.getCampingLocation, required this.getCampingSite}) : super(HomeStateInitial()) {
    on<HomeEventGetCampingLocations>((event, emit) async {
      emit(HomeStateLoading());
      Either<Failure, List<CampingLocation>> result = await getCampingLocation.execute();
      result.fold(
        (failure) => emit(HomeStateError("Error")),
        (success) => emit(HomeStateSuccessCampingLocation(success)),
      );
    });

    on<HomeEventGetCampingSite>((event, emit) async {
      emit(HomeStateLoading());
      Either<Failure, List<CampingSite>> result = await getCampingSite.execute(event.locationId);
      result.fold(
        (failure) => emit(HomeStateError("Error")),
        (success) => emit(HomeStateSuccessCampingSite(success)),
      );
    });
  }
}
