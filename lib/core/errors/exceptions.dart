abstract class Exceptions implements Exception {
  final String message;

  Exceptions(this.message);
}

class FetchFailureException extends Exceptions {
  FetchFailureException(super.message);
}

class BadRequestException extends Exceptions {
  BadRequestException(super.message);
}

class UnauthorisedException extends Exceptions {
  UnauthorisedException(super.message);
}

class ForbiddenException extends Exceptions {
  ForbiddenException(super.message);
}

class InvalidInputException extends Exceptions {
  InvalidInputException(super.message);
}

class NotFoundException extends Exceptions {
  NotFoundException(super.message);
}

class ServerException extends Exceptions {
  ServerException(super.message);
}
