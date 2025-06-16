import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../utils/api_error_handler.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<List<User>> getUsers() async {
    try {
      return await _apiService.getUsers();
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleError(e));
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<User> getUserById(String id) async {
    try {
      return await _apiService.getUserById(id);
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleError(e));
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  Future<User> createUser(User user, String token) async {
    try {
      return await _apiService.createUser(user, token);
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleError(e));
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
