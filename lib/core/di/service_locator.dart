import 'package:api/core/config/api_config.dart';
import 'package:api/core/utils/app_interceptors.dart';
import 'package:api/features/user/data/repositories/user_repository.dart';
import 'package:api/features/user/presentation/cubit/user_cubit.dart';
import 'package:api/core/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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

  getIt.registerLazySingleton<UserCubit>(
    () => UserCubit(getIt<UserRepository>()),
  );
}
