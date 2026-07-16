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
          message: 'Tu sesion expiro. Inicia sesion nuevamente.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'FORBIDDEN':
        return AppFailure(
          type: FailureType.forbidden,
          message: 'No tienes acceso a este recurso.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'NOT_FOUND':
        return AppFailure(
          type: FailureType.notFound,
          message: 'Recurso no encontrado.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'CONFLICT':
        return AppFailure(
          type: FailureType.conflict,
          message: 'La accion entra en conflicto con el estado actual.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'BUSINESS_RULE_VIOLATION':
        return AppFailure(
          type: FailureType.businessRule,
          message: 'Esta accion viola una regla de negocio.',
          requestId: exception.requestId,
          code: exception.code,
        );
      case 'VALIDATION_ERROR':
        return AppFailure(
          type: FailureType.validation,
          message: 'Los datos enviados no son validos.',
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
