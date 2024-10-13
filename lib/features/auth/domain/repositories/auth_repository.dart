



import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> signup(Auth auth);
  Future<Either<Failure, Auth>> login(Auth auth,String? fcmToken);
  Future<Either<Failure, Auth>> getCurrentUser();
  Future<Either<Failure, Unit>>  signOut(String fcmToken);
}
