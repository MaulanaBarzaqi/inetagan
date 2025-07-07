abstract class FailureException implements Exception {
  final String message;

  FailureException(this.message);
}

class ServerException extends FailureException {
  ServerException(super.message);
}

class BadRequestException extends FailureException {
  BadRequestException(super.message);
}

class UnauthorisedException extends FailureException {
  UnauthorisedException(super.message);
}

class ForbiddenException extends FailureException {
  ForbiddenException(super.message);
}

class NotFoundException extends FailureException {
  NotFoundException(super.message);
}

class TimeoutException extends FailureException {
  TimeoutException(super.message);
}

class ConnnectionException extends FailureException {
  ConnnectionException(super.message);
}

class CachedException extends FailureException {
  CachedException(super.message);
}

class InvalidInputException extends FailureException {
  InvalidInputException(super.message);
}

class FetchFailureException extends FailureException {
  FetchFailureException(super.message);
}
