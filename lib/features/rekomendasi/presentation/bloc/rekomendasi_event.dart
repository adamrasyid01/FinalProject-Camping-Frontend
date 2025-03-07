part of 'rekomendasi_bloc.dart';

abstract class RekomendasiEvent extends Equatable {}

class RekomendasiEventSaveUserPreferenceCriteria extends RekomendasiEvent {
  final UserPreferenceCriteria userPreferenceCriteria;

  RekomendasiEventSaveUserPreferenceCriteria(this.userPreferenceCriteria);
  @override
  List<Object> get props => [userPreferenceCriteria];
}