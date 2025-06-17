import 'package:api/core/network/api_error_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  factory ApiResult.success(T data) = Success<T>;

  factory ApiResult.error(NetworkExceptions networkExceptions) = Error<T>;
}
