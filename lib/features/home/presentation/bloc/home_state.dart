part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final List<CampingLocation> campingLocations;
  final List<CampingSite> campingSites;
  

  const HomeState({
    this.campingLocations = const [],
    this.campingSites = const [],
  });

  @override
  List<Object> get props => [campingLocations, campingSites];
}

class HomeStateInitial extends HomeState {
  const HomeStateInitial();
}

class HomeStateLoading extends HomeState {
  const HomeStateLoading();
}

class HomeStateLoadingMoreSites extends HomeState {
  const HomeStateLoadingMoreSites({
    required super.campingSites,
  });
}

class HomeStateSuccessLocations extends HomeState {
  const HomeStateSuccessLocations({
    required List<CampingLocation> campingLocations,
  }) : super(campingLocations: campingLocations);
}

class HomeStateSuccessSites extends HomeState {
  final bool hasReachedMax;
  final int currentPage;

  const HomeStateSuccessSites({
    required super.campingSites,
    required this.hasReachedMax,
    required this.currentPage,
  });

  @override
  List<Object> get props => [campingSites, hasReachedMax, currentPage];
}

class HomeStateError extends HomeState {
  final String message;

  const HomeStateError(this.message);

  @override
  List<Object> get props => [message, ...super.props];
}

// DETAIL SITE
class HomeStateGetDetailSites extends HomeState {
  final CampingSite campingSite;

  const HomeStateGetDetailSites({
    required this.campingSite,
  });

  @override
  List<Object> get props => [campingSite];
}
