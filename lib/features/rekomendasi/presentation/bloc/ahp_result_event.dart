import 'package:equatable/equatable.dart';

abstract class AHPResultEvent extends Equatable {}

class AHPResultEventGetAHPResult extends AHPResultEvent {
  final int page;
  final int limit;
  final int? locationId;
  final int? rating;
  AHPResultEventGetAHPResult(
      {this.page = 1, this.limit = 10, this.locationId, this.rating});
  @override
  List<Object?> get props => [page, limit, locationId, rating];
}
