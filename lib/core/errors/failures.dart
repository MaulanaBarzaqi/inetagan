// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(super.message);
}

class UnauthorisedFailure extends Failure {
  const UnauthorisedFailure(super.message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

class ConnnectionFailure extends Failure {
  const ConnnectionFailure(super.message);
}

class CachedFailure extends Failure {
  const CachedFailure(super.message);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}

class FetchFailure extends Failure {
  const FetchFailure(super.message);
}
