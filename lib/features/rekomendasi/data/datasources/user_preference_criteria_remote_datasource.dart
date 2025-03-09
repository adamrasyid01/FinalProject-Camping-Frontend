import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';

abstract class UserPreferenceCriteriaRemoteDatasource {
  Future<List<UserPreferenceCriteriaModel>> saveUserPreferenceCriteria(
      List<UserPreferenceCriteriaModel> criteriaList);
}

class UserPreferenceCriteriaRemoteDataSourceImplementation
    extends UserPreferenceCriteriaRemoteDatasource {
  final DioClient dio;

  UserPreferenceCriteriaRemoteDataSourceImplementation({required this.dio});

  @override
  Future<List<UserPreferenceCriteriaModel>> saveUserPreferenceCriteria(
      List<UserPreferenceCriteriaModel> criteriaList) async {
    try {
      // Ubah List<UserPreferenceCriteriaModel> menjadi List<Map<String, dynamic>>
      final List<Map<String, dynamic>> jsonData = criteriaList.map((criteria) => criteria.toJson()).toList();

      print("Sending request to: ${ApiEndpoints.userPreferenceCriteria}");
      print("Request Data: ${jsonData}");

      // Kirim request ke API
      final response = await dio.postRequest(ApiEndpoints.userPreferenceCriteria,data: {"preference_criteria": jsonData});

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      // Debug
      print(response.data['result'] is List);
      // Pastikan response memiliki data yang benar
      if (response.data != null && response.data['result'] is List) {
        final List<UserPreferenceCriteriaModel> parsedList =
            (response.data['result'] as List<dynamic>)
                .map((item) => UserPreferenceCriteriaModel.fromJson(item))
                .toList();

        print(parsedList); // Print hasil parsing sebelum return
        return parsedList;
      } else {
        throw ServerFailure("Invalid response format");
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
