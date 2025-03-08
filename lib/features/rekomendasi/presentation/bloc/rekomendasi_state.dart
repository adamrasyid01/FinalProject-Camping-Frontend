part of 'rekomendasi_bloc.dart';

abstract class RekomendasiState extends Equatable {}
class RekomendasiInitial extends RekomendasiState {
  @override
  List<Object> get props => [];
}
class RekomendasiStateLoading extends RekomendasiState {
  @override
  List<Object> get props => [];
}
class RekomendasiStateError extends RekomendasiState {
  final String message;

  RekomendasiStateError(this.message);

  @override
  List<Object> get props => [message];
}
class RekomendasiStateSuccess extends RekomendasiState {
  final List<UserPreferenceCriteria> userPreferenceCriteria;

  RekomendasiStateSuccess(this.userPreferenceCriteria);

  @override
  List<Object> get props => [userPreferenceCriteria];
}
