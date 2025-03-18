part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeEventGetCampingLocations extends HomeEvent{
  @override
  List<Object> get props => [];
}

class HomeEventGetCampingSite extends HomeEvent{
  final int locationId;
  HomeEventGetCampingSite({required this.locationId});
  @override
  List<Object> get props => [locationId];
}

