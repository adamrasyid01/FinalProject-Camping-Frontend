import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/usecases/get_ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_event.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_state.dart';

class AHPResultBloc extends Bloc<AHPResultEvent, AHPResultState> {
  final GetAHPResult getAHPResult;
  
  AHPResultBloc({required this.getAHPResult}) : super(AHPResultInitial()) {
    on<AHPResultEventGetAHPResult>((event, emit) async {
      try {
        // Jika halaman pertama atau ada perubahan filter tampilkan loading state awal (AHPResultLoading)
        if (event.page == 1 || event.isFilterChanged) {
          emit(AHPResultLoading());
        } else {
          // Jika loading halaman berikutnya tampilkan loading state dengan data yang sudah ada (AHPResultLoadingMore)
          emit(AHPResultLoadingMore(ahpResults: state.ahpResults));
        }

        final result = await getAHPResult.execute(
          page: event.page,
          limit: event.limit,
          locationId: event.locationId,
          rating: event.rating,
        );

        // PENANGANAN DATA
        result.fold(
          (failure) => emit(AHPResultError(failure.message, ahpResults: state.ahpResults)),
          (data) {
            if (event.page == 1 || event.isFilterChanged) {
              // Fresh load
              // Fresh Load (halaman 1 atau filter berubah) Gunakan data baru sepenuhnya hasReachedMax di-set true jika jumlah data < limit
              emit(AHPResultSuccess(
                ahpResults: data,
                hasReachedMax: data.length < event.limit,
                currentPage: event.page,
              ));
            } else {
              // Pagination load
              // Pagination Load (halaman > 1) Gabungkan data lama dengan data baru hasReachedMax di-set true jika jumlah data baru < limit
              final allResults = [...state.ahpResults, ...data];
              emit(AHPResultSuccess(
                ahpResults: allResults,
                hasReachedMax: data.length < event.limit,
                currentPage: event.page,
              ));
            }
          },
        );
      } catch (e) {
        emit(AHPResultError(e.toString(), ahpResults: state.ahpResults));
      }
    });
  }
}