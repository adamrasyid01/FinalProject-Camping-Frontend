import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/usecases/get_ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_event.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_state.dart';

class AHPResultBloc extends Bloc<AHPResultEvent, AHPResultState> {
  final GetAHPResult getAHPResult;

  AHPResultBloc({required this.getAHPResult}) : super(AHPResultInitial()) {
    on<AHPResultEvent>((event, emit) async {
      print("ahp result --------------------------------------");

      emit(AHPResultLoading());
      Either<Failure, List<AHPResult>> result = await getAHPResult.execute();
      result.fold(
        (failure) => emit(AHPResultError(failure.message)),
        (data) => emit(AHPResultSuccess(data)),
      );
    });
  }
}
