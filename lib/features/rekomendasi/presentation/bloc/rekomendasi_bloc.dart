import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/user_preference_criteria.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/usecases/save_user_preference_criteria.dart';

part 'rekomendasi_event.dart';
part 'rekomendasi_state.dart';

class RekomendasiBloc extends Bloc<RekomendasiEvent, RekomendasiState> {
  final SaveUserPreferenceCriteria saveUserPreferenceCriteria;
  RekomendasiBloc({required this.saveUserPreferenceCriteria})
      : super(RekomendasiInitial()) {
    on<RekomendasiEventSaveUserPreferenceCriteria>((event, emit) async {
      emit(RekomendasiStateLoading());
      Either<Failure, UserPreferenceCriteria> result = await saveUserPreferenceCriteria.execute(event.userPreferenceCriteria);
      result.fold(
        (failure) => emit(RekomendasiStateError("Error")),
        (criteria) => emit(RekomendasiStateSuccess(criteria)),
      );
      
    });
  }
}
