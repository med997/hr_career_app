import 'package:equatable/equatable.dart';

import '../strings/failures.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure([this.message = 'An unexpected error occured!']);

}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String? messageServer;
  ServerFailure({this.messageServer = SERVER_FAILURE_MESSAGE});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  AuthFailure(super.message);
  @override
  List<Object?> get props => [message];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

