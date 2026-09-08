import 'dart:io';
import 'package:dio/dio.dart';
import 'failures.dart';

class ApiErrorHandler {
  /// Converts any dynamic error/exception into a human-readable String message.
  static String getMessage(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              return "Connection timeout with the server. Please try again.";
            case DioExceptionType.sendTimeout:
              return "Send timeout with the server. Please check your internet connection.";
            case DioExceptionType.receiveTimeout:
              return "Receive timeout in connection with the API server.";
            case DioExceptionType.cancel:
              return "Request to the API server was cancelled.";
            case DioExceptionType.badCertificate:
              return "Security certificate validation failed.";
            case DioExceptionType.connectionError:
              return "No internet connection or server is unreachable.";
            case DioExceptionType.badResponse:
              return _handleBadResponse(error.response);
            case DioExceptionType.unknown:
            default:
              if (error.error is SocketException) {
                return "No internet connection available.";
              }
              return "An unexpected network error occurred.";
          }
        } else if (error is SocketException) {
          return "No internet connection. Please check your network.";
        } else if (error is FormatException) {
          return "Bad response format from server.";
        } else {
          return "An unexpected error occurred.";
        }
      } catch (e) {
        return "An unknown error occurred.";
      }
    } else if (error is String) {
      return error;
    } else {
      return "Something went wrong. Please try again.";
    }
  }

  /// Converts an error into a structured [Failure] object.
  static Failure handle(dynamic error) {
    final message = getMessage(error);
    int? statusCode;

    if (error is DioException) {
      statusCode = error.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        return UnauthorizedFailure(message);
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError ||
          error.error is SocketException) {
        return NetworkFailure(message);
      }
    } else if (error is SocketException) {
      return NetworkFailure(message);
    }

    return ServerFailure(message, statusCode: statusCode);
  }

  /// Internal helper to extract error message from API HTTP bad response (400, 401, 404, 500, etc.)
  static String _handleBadResponse(Response? response) {
    if (response == null) return "Unknown server error.";

    final statusCode = response.statusCode;
    final data = response.data;

    // Try extracting backend error message from JSON response body
    if (data is Map<String, dynamic>) {
      if (data.containsKey('message') && data['message'] != null && data['message'].toString().isNotEmpty) {
        return data['message'].toString();
      }
      if (data.containsKey('error') && data['error'] != null) {
        return data['error'].toString();
      }
      if (data.containsKey('errors') && data['errors'] is List && (data['errors'] as List).isNotEmpty) {
        final firstError = data['errors'][0];
        if (firstError is Map && firstError.containsKey('message')) {
          return firstError['message'].toString();
        }
        return firstError.toString();
      }
    }

    // Default status code messages if body couldn't be parsed
    switch (statusCode) {
      case 400:
        return "Bad request. Please check your inputs.";
      case 401:
        return "Unauthorized. Please log in again.";
      case 403:
        return "Access forbidden.";
      case 404:
        return "Requested resource not found.";
      case 409:
        return "Conflict error occurred.";
      case 500:
        return "Internal server error. Please try again later.";
      case 503:
        return "Service unavailable. Server is under maintenance.";
      default:
        return "Failed with status code: $statusCode";
    }
  }
}
