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

class HomeStateSuccess extends HomeState {
  final List<CampingLocation> campingLocation;

  HomeStateSuccess(this.campingLocation);

  @override
  List<Object> get props => [campingLocation];
}
