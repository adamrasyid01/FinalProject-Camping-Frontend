import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/ahp_result_model.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/usecases/get_ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_event.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_state.dart';

class AHPResultBloc extends Bloc<AHPResultEvent, AHPResultState> {
  final GetAHPResult getAHPResult;

  AHPResultBloc({required this.getAHPResult}) : super(AHPResultInitial()) {
    on<AHPResultEventGetAHPResult>((event, emit) async {
      if (state is AHPResultInitial) {
        Either<Failure, List<AHPResult>> response = await getAHPResult.execute(
            locationId: event.locationId,
            rating: event.rating,
            page: event.page,
            limit: event.limit);

        response.fold(
          (failure) {
            // Handle failure case
            emit(AHPResultError(failure.toString()));
          },
          (data) {
            emit(AHPResultSuccess(ahpResults: data, hasReachedMax: false));
          },
        );
      } else {
        AHPResultSuccess ahpLoaded = state as AHPResultSuccess;
        Either<Failure, List<AHPResult>> result = await getAHPResult.execute(
            locationId: event.locationId,
            rating: event.rating,
            page: event.page,
            limit: event.limit);

        result.fold(
          (failure) {
            // Handle failure case
            emit(AHPResultError(failure.toString()));
          },
          (data) {
            if (data.isEmpty) {
              emit(ahpLoaded.copyWith(hasReachedMax: true));
            } else {
              emit(AHPResultSuccess(
                  ahpResults: ahpLoaded.ahpResults + data,
                  hasReachedMax: false));
            }
          },
        );
      }
    });
  }
}
