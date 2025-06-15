import 'package:equatable/equatable.dart';

class UserPreferenceCriteria extends Equatable {
  
  final int criteria_id;
  final double weight;

  const UserPreferenceCriteria({

    required this.criteria_id,
    required this.weight,
  });

  @override
  List<Object> get props => [criteria_id, weight];
}
