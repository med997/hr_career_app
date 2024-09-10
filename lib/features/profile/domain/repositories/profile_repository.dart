import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getUserProfile();
}
