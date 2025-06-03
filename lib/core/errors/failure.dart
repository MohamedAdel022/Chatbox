abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}
