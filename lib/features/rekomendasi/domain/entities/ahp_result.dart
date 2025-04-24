import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

class AHPResult extends Equatable {
  final int camping_site_id;
  final double final_score;
  final CampingSite campingSite;
  
  const AHPResult({
    required this.camping_site_id,
    required this.final_score,
    required this.campingSite,
  });
  
  @override
  // TODO: implement props
  List<Object> get props => [camping_site_id,final_score,campingSite];
}
