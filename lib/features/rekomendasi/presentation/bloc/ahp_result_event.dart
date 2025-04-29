import 'package:equatable/equatable.dart';

abstract class AHPResultEvent extends Equatable {}

class AHPResultEventGetAHPResult extends AHPResultEvent {
  final int? locationId;
  final int? rating;
  AHPResultEventGetAHPResult({this.locationId, this.rating});
  @override
  List<Object?> get props => [locationId, rating];
  
}
