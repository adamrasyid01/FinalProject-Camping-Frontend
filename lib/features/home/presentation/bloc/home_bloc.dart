import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
 final GetCampingLocation getCampingLocation;
  HomeBloc({required this.getCampingLocation}) : super(HomeStateInitial()) {
    on<HomeEventGetCurrentUser>((event, emit) async {
      emit(HomeStateLoading());
      Either<Failure, List<CampingLocation>> result = await getCampingLocation.execute();
      result.fold(
        (failure) => emit(HomeStateError("Error")),
        (success) => emit(HomeStateSuccess(success)),
      );
    });
  }
}
