
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);


  Future<Either<Failure, Auth>> call(Auth auth) async {
    return await repository.signup(auth);
  }

  Future<Either<Failure, Unit>> signupWithOtp(String token,String email) async {
    return await repository.signupWithOtp(token,email);
  }
  Future<Either<Failure, Unit>> resendOtp(String email)  async {
    return await repository.resendOtp(email);
  }
}