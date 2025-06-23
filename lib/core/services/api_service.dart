import 'package:api/features/user/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://gorest.co.in/public/v2/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("users")
  Future<List<User>> getUsers();

  @GET("users/{id}")
  Future<User> getUserById(@Path('id') String id);

  @POST("users")
  Future<User> createUser(@Body() User user, @Header('Authorization') String token);

  @DELETE("users/{id}")
  Future<dynamic> deleteUser(@Path('id') String id, @Header('Authorization') String token);
}
