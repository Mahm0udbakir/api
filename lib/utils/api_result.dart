import 'package:api/utils/api_error_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  factory ApiResult.success(T data) = Success<T>;

  factory ApiResult.error(NetworkExceptions networkExceptions) = Error<T>;
}
