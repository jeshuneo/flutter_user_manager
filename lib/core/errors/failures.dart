abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection');
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}