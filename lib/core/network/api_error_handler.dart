import 'dart:io';

import 'package:api/utils/error_model.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_handler.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    List<ErrorModel> listOfErrors =
        List.from(response?.data).map((e) => ErrorModel.fromJson(e)).toList();
    String allErrors = listOfErrors
        .map((e) => "${e.field} : ${e.message}  ")
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "");
    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 403:
        return NetworkExceptions.unauthorizedRequest(allErrors);
      case 404:
        return NetworkExceptions.notFound(allErrors);
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(allErrors);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        var responseCode = statusCode;
        return NetworkExceptions.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = NetworkExceptions.handleResponse(
                error.response,
              );
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            default:
              networkExceptions = const NetworkExceptions.unexpectedError();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (e) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    switch (networkExceptions.runtimeType) {
      case NotImplemented _:
        errorMessage = "Not Implemented";
        break;
      case RequestCancelled _:
        errorMessage = "Request Cancelled";
        break;
      case InternalServerError _:
        errorMessage = "Internal Server Error";
        break;
      case NotFound _:
        errorMessage = (networkExceptions as NotFound).reason;
        break;
      case ServiceUnavailable _:
        errorMessage = "Service unavailable";
        break;
      case MethodNotAllowed _:
        errorMessage = "Method Allowed";
        break;
      case BadRequest _:
        errorMessage = "Bad request";
        break;
      case UnauthorizedRequest _:
        errorMessage = (networkExceptions as UnauthorizedRequest).reason;
        break;
      case UnprocessableEntity _:
        errorMessage = (networkExceptions as UnprocessableEntity).reason;
        break;
      case UnexpectedError _:
        errorMessage = "Unexpected error occurred";
        break;
      case RequestTimeout _:
        errorMessage = "Connection request timeout";
        break;
      case NoInternetConnection _:
        errorMessage = "No internet connection";
        break;
      case Conflict _:
        errorMessage = "Error due to a conflict";
        break;
      case SendTimeout _:
        errorMessage = "Send timeout in connection with API server";
        break;
      case UnableToProcess _:
        errorMessage = "Unable to process the data";
        break;
      case DefaultError _:
        errorMessage = (networkExceptions as DefaultError).error;
        break;
      case FormatException _:
        errorMessage = "Unexpected error occurred";
        break;
      case NotAcceptable _:
        errorMessage = "Not acceptable";
        break;
      default:
        errorMessage = "Unexpected error occurred";
    }
    return errorMessage;
  }
}
