import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rekomendasi_event.dart';
part 'rekomendasi_state.dart';

class RekomendasiBloc extends Bloc<RekomendasiEvent, RekomendasiState> {
  RekomendasiBloc() : super(RekomendasiInitial()) {
    on<RekomendasiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
