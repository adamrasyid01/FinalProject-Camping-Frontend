import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';


abstract class AHPResultState extends Equatable {
  final List<AHPResult> ahpResults;
  const AHPResultState({this.ahpResults = const []});
  @override
  List<Object> get props => [ahpResults];
}

class AHPResultInitial extends AHPResultState {}

class AHPResultLoading extends AHPResultState {}

class AHPResultLoadingMore extends AHPResultState {
  const AHPResultLoadingMore({required super.ahpResults});
}

class AHPResultSuccess extends AHPResultState {
  final bool hasReachedMax;
  final int currentPage;
  
  const AHPResultSuccess({
    required super.ahpResults,
    required this.hasReachedMax,
    required this.currentPage,
  });

  @override
  List<Object> get props => [ahpResults, hasReachedMax, currentPage];
}

class AHPResultError extends AHPResultState {
  final String message;
  
  const AHPResultError(
    this.message, {
    required super.ahpResults,
  });

  @override
  List<Object> get props => [message, ...super.props];
}