

import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';

abstract class AHPResultState extends Equatable{}
class AHPResultInitial extends AHPResultState {
  @override
  List<Object?> get props => [];
}
class AHPResultLoading extends AHPResultState {
  @override
  List<Object?> get props => [];
}
class AHPResultError extends AHPResultState {
  final String message;

  AHPResultError(this.message);

  @override
  List<Object?> get props => [message];
}
class AHPResultSuccess extends AHPResultState {
  final List<AHPResult> ahpResult;

  AHPResultSuccess(this.ahpResult);

  @override
  List<Object?> get props => [ahpResult];
}