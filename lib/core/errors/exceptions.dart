/// Base exception class
class AppException implements Exception {
  final String message;
  final int? code;
  
  const AppException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'AppException: $message (Code: $code)';
}

/// Server exception
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'ServerException: $message (Code: $code)';
}

/// Cache exception
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'CacheException: $message (Code: $code)';
}

/// Network exception
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'NetworkException: $message (Code: $code)';
}

/// Database exception
class DatabaseException extends AppException {
  const DatabaseException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'DatabaseException: $message (Code: $code)';
}

/// Validation exception
class ValidationException extends AppException {
  final Map<String, String>? errors;
  
  const ValidationException({
    required super.message,
    super.code,
    this.errors,
  });
  
  @override
  String toString() => 'ValidationException: $message (Code: $code, Errors: $errors)';
}

/// Authentication exception
class AuthenticationException extends AppException {
  const AuthenticationException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'AuthenticationException: $message (Code: $code)';
}

/// Authorization exception
class AuthorizationException extends AppException {
  const AuthorizationException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'AuthorizationException: $message (Code: $code)';
}

/// Not found exception
class NotFoundException extends AppException {
  const NotFoundException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'NotFoundException: $message (Code: $code)';
}

/// File operation exception
class FileException extends AppException {
  const FileException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'FileException: $message (Code: $code)';
}

/// Biometric exception
class BiometricException extends AppException {
  const BiometricException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'BiometricException: $message (Code: $code)';
}

/// Sync exception
class SyncException extends AppException {
  const SyncException({
    required super.message,
    super.code,
  });
  
  @override
  String toString() => 'SyncException: $message (Code: $code)';
}

