

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/auth/domain/repositories/auth_repository.dart';

class DeleteAuthUseCase  {
  final AuthRepository repository;

  DeleteAuthUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String fcmToken) async {
    return await repository.signOut(fcmToken);
  }
}