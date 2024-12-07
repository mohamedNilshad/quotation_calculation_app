class FailureException implements Exception {
  final String message;

  FailureException(this.message);
}

class RequestException implements FailureException {
  @override
  final String message;

  RequestException(this.message);
}

class ProcessingFailedException extends FailureException {
  ProcessingFailedException(super.message);
}

class TimeoutConnectionException extends FailureException {
  TimeoutConnectionException(super.message);
}

class NotFoundException extends FailureException {
  NotFoundException(super.message);
}
