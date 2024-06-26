import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'exceptions/api_exception.dart';
import 'exceptions/app_exception.dart';
import 'exceptions/network_exception.dart';
import 'exceptions/not_found_exception.dart';
import 'exceptions/service_unavailable_exception.dart';

Exception handleError(String error, {StackTrace? stackTrace}) {
  return AppException(message: error, stackTrace: stackTrace);
}

Exception handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.cancel:
      return AppException(message: 'Request to API server was cancelled');
    case DioExceptionType.connectionTimeout:
      return AppException(message: 'Connection timeout with API server');
    case DioExceptionType.connectionError:
      return NetworkException('There is no internet connection');
    case DioExceptionType.unknown:
      return NetworkException(e.error.toString());
    case DioExceptionType.receiveTimeout:
      return TimeoutException('Receive timeout in connection with API server');
    case DioExceptionType.sendTimeout:
      return TimeoutException('Send timeout in connection with API server');
    case DioExceptionType.badCertificate:
    case DioExceptionType.badResponse:
      return _parseDioErrorResponse(e);
  }
}

Exception _parseDioErrorResponse(DioException dioError) {
  int statusCode = dioError.response?.statusCode ?? -1;
  String? status;
  String? serverMessage;

  try {
    if (statusCode == -1 || statusCode == HttpStatus.ok) {
      statusCode = dioError.response?.data['status_code'];
    }
    status = dioError.response?.data['status_code'].toString();
    serverMessage = dioError.response?.data['status_message'];
  } catch (e, _) {
    serverMessage = 'Something went wrong. Please try again later.';
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException('Service Temporarily Unavailable');
    case HttpStatus.notFound:
      return NotFoundException(serverMessage ?? '', status ?? '');
    default:
      return ApiException(
          httpCode: statusCode,
          status: status ?? '',
          message: serverMessage ?? '');
  }
}
