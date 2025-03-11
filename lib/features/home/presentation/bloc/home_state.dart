part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeStateInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeStateLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);

  @override
  List<Object> get props => [message];
}

class HomeStateSuccessCampingLocation extends HomeState {
  final List<CampingLocation> campingLocation;

  HomeStateSuccessCampingLocation(this.campingLocation);

  @override
  List<Object> get props => [campingLocation];
}
class HomeStateSuccessCampingSite extends HomeState {
  final List<CampingSite> campingSite;

  HomeStateSuccessCampingSite(this.campingSite);

  @override
  List<Object> get props => [campingSite];
}

class HomeStateSuccessCampingLocationWithSites extends HomeState{
  final CampingLocationWithSites campingLocationWithSites;

  HomeStateSuccessCampingLocationWithSites(this.campingLocationWithSites);

  @override
  List<Object> get props => [campingLocationWithSites];
}