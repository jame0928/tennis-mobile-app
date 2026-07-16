import 'api_exception.dart';

enum FailureType {
  unauthenticated,
  forbidden,
  notFound,
  conflict,
  businessRule,
  validation,
  unknown,
}

class AppFailure {
  const AppFailure({
    required this.type,
    required this.message,
    this.requestId,
    this.code,
  });

  final FailureType type;
  final String message;
  final String? requestId;
  final String? code;
}

class ErrorMapper {
  AppFailure fromApiException(ApiException exception) {
    switch (exception.code) {
      case 'UNAUTHENTICATED':
        return AppFailure(
          type: FailureType.unauthenticated,
          message: 'Your session expired. Please login again.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'FORBIDDEN':
        return AppFailure(
          type: FailureType.forbidden,
          message: 'You do not have access to this resource.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'NOT_FOUND':
        return AppFailure(
          type: FailureType.notFound,
          message: 'Resource not found.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'CONFLICT':
        return AppFailure(
          type: FailureType.conflict,
          message: 'The action conflicts with current state.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'BUSINESS_RULE_VIOLATION':
        return AppFailure(
          type: FailureType.businessRule,
          message: 'This action violates a business rule.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'VALIDATION_ERROR':
        return AppFailure(
          type: FailureType.validation,
          message: 'Submitted data is invalid.',
          requestId: exception.requestId,
          code: exception.code,
        );
      default:
        return AppFailure(
          type: FailureType.unknown,
          message: exception.message,
          requestId: exception.requestId,
          code: exception.code,
        );
    }
  }
}
