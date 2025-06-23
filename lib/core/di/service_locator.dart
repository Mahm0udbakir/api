import 'package:api/core/cache/cache_helper.dart';
import 'package:api/core/config/api_config.dart';
import 'package:api/core/utils/app_interceptors.dart';
import 'package:api/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:api/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:api/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:api/features/auth/domain/repositories/auth_repository.dart';
import 'package:api/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  // External
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getIt.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);

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



  // Auth Feature
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: getIt(),
      googleSignIn: getIt(),
      facebookAuth: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepository: getIt()),
  );
}
