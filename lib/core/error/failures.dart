import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure([this.message = 'An unexpected error occured!']);

}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

