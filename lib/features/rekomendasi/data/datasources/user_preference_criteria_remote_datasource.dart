import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';

abstract class UserPreferenceCriteriaRemoteDatasource {
  Future<UserPreferenceCriteriaModel> saveUserPreferenceCriteria(
      UserPreferenceCriteriaModel criteria);
}

class UserPreferenceCriteriaRemoteDataSourceImplementation
    extends UserPreferenceCriteriaRemoteDatasource {
  final DioClient dio;

  UserPreferenceCriteriaRemoteDataSourceImplementation({required this.dio});

  @override
  Future<UserPreferenceCriteriaModel> saveUserPreferenceCriteria(
      UserPreferenceCriteriaModel criteria) async {
    try {
      final response =
          await dio.postRequest(ApiEndpoints.baseUrl, data: criteria.toJson());
      return UserPreferenceCriteriaModel.fromJson(response.data['result']);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
