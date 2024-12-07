import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
}

class ConnectionFailure extends Failure {
  final String message;
  const ConnectionFailure(this.message) : super(message);
  @override
  List<Object> get props => [];
}

class TimeoutFailure extends Failure {
  final String message;
  const TimeoutFailure(this.message) : super(message);
  @override
  List<Object> get props => [];
}


class AppFailure extends Failure {
  final String message;
  const AppFailure(this.message) : super(message);
  @override
  List<Object> get props => [];
}