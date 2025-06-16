import 'package:api/cubit/user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import '../utils/app_interceptors.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register Dio instance
  getIt.registerLazySingleton<Dio>(() {
    final dio =
        Dio()
          ..options.baseUrl = ApiConfig.baseUrl
          ..options.connectTimeout = Duration(
            milliseconds: ApiConfig.connectTimeout,
          )
          ..options.receiveTimeout = Duration(
            milliseconds: ApiConfig.receiveTimeout,
          );
    dio.interceptors.add(AppInterceptors());
    return dio;
  });

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<UserCubit>(() => UserCubit(getIt<UserRepository>()));
}
