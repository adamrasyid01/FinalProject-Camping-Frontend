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
  final int page;
  final String? search;
  final int limit;
  HomeEventGetCampingSite(
      {required this.locationId, this.search, this.limit = 10, this.page = 1});
  @override
  List<Object?> get props => [locationId, search, limit, page];
}

class HomeEventGetDetailSites extends HomeEvent {
  final int campingLocationId;
  final int campingSiteId;

  HomeEventGetDetailSites({
    required this.campingLocationId,
    required this.campingSiteId,
  });

  @override
  List<Object> get props => [campingLocationId, campingSiteId];
}