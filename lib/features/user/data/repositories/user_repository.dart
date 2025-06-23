import 'package:api/core/network/api_error_handler.dart';
import 'package:api/core/utils/api_result.dart';
import 'package:api/features/user/data/models/user_model.dart';
import 'package:api/core/services/api_service.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<ApiResult<List<User>>> getUsers() async {
    try {
      final users = await _apiService.getUsers();
      return ApiResult.success(users);
    } on DioException catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.unexpectedError());
    }
  }

  Future<ApiResult<User>> getUserById(String id) async {
    try {
      final response = await _apiService.getUserById(id);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.unexpectedError());
    }
  }

  Future<ApiResult<User>> createUser(User user, String token) async {
    try {
      final response = await _apiService.createUser(user, token);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.unexpectedError());
    }
  }
  
  Future<ApiResult<dynamic>> deleteUser(String id, String token) async {
    try {
      final response = await _apiService.deleteUser(id, token);
      return ApiResult.success(response);
      } on DioException catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.unexpectedError());
    }
  }
}
