

import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/splash/data/models/user_preference_criteria_model.dart';

abstract class UserPreferenceCriteriaRemoteDatasource {
  Future<List<UserPreferenceCriteriaModel>> saveUserPreferenceCriteria();
}

class UserPreferenceCriteriaRemoteDataSourceImplementation extends UserPreferenceCriteriaRemoteDatasource{
  final DioClient dio;

  UserPreferenceCriteriaRemoteDataSourceImplementation({required this.dio});

  @override
    Future<List<UserPreferenceCriteriaModel>> saveUserPreferenceCriteria() async{
      try {
        final response = await dio.postRequest(ApiEndpoints.baseUrl);
        return UserPreferenceCriteriaModel.fromJsonList(response.data['result']);
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    }
}