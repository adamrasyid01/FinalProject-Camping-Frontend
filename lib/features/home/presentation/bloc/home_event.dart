part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeEventGetCampingLocations extends HomeEvent{
  @override
  List<Object> get props => [];
}

class HomeEventGetCampingSite extends HomeEvent{
  final int locationId;
  final String? search;
  HomeEventGetCampingSite({required this.locationId, this.search});
  @override
  List<Object?> get props => [locationId, search];
}

