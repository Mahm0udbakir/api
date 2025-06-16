import 'package:api/utils/api_result.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../utils/api_error_handler.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<ApiResult<List<User>>> getUsers() async {
    try {
      final users = await _apiService.getUsers();
      return ApiResult.success(users);
    } on DioException catch (e) {
      return ApiResult.error(NetworkExceptions.getDioException(e));
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<ApiResult<User>> getUserById(String id) async {
    try {
      final response = await _apiService.getUserById(id);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.error(NetworkExceptions.getDioException(e));
    } catch (e) {
      return ApiResult.error(NetworkExceptions.unexpectedError());
    }
  }

  Future<ApiResult<User>> createUser(User user, String token) async {
    try {
      final response = await _apiService.createUser(user, token);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.error(NetworkExceptions.getDioException(e));
    } catch (e) {
      return ApiResult.error(NetworkExceptions.unexpectedError());
    }
  }
  
  Future<ApiResult<dynamic>> deleteUser(String id, String token) async {
    try {
      final response = await _apiService.deleteUser(id, token);
      return ApiResult.success(response);
      } on DioException catch (e) {
      return ApiResult.error(NetworkExceptions.getDioException(e));
    } catch (e) {
      return ApiResult.error(NetworkExceptions.unexpectedError());
    }
  }
}
