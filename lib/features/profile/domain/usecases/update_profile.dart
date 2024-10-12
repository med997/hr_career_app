import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/failures.dart';
class UpdateProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase(this.profileRepository);

  Future<Either<Failure, Unit>> call(Profile profile) async {
    return await profileRepository.updateProfile(profile);
  }
}