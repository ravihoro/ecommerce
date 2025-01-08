abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class DatabaseInsertFailure extends Failure {
  const DatabaseInsertFailure(super.message);
}

class DatabaseDeleteFailure extends Failure {
  const DatabaseDeleteFailure(super.message);
}

class DatabaseFetchFailure extends Failure {
  const DatabaseFetchFailure(super.message);
}

class CustomFailure extends Failure {
  const CustomFailure(super.message);
}
