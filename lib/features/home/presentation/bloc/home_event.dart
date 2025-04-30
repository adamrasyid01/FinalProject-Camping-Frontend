part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeEventGetCampingLocations extends HomeEvent {
  final String filter;

  HomeEventGetCampingLocations({required this.filter});

  @override
  List<Object> get props => [filter];
}

class HomeEventGetCampingSite extends HomeEvent {
  final int locationId;
  final String? search;
  HomeEventGetCampingSite({required this.locationId, this.search});
  @override
  List<Object?> get props => [locationId, search];
}
