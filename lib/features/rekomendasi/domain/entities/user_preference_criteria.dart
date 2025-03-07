import 'package:equatable/equatable.dart';

class UserPreferenceCriteria extends Equatable {
  final int id;
  final int user_preference_id;
  final int criteria_id;
  final double weight;

  UserPreferenceCriteria({
    required this.id,
    required this.user_preference_id,
    required this.criteria_id,
    required this.weight,
  });

  @override
  List<Object> get props => [id, user_preference_id, criteria_id, weight];
}
