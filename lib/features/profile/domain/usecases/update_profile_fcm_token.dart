
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileFcmToken {
  final ProfileRepository profileRepository;

  UpdateProfileFcmToken(this.profileRepository);

  Future<Either<Failure, Profile>> updateFcmToken(Profile profile) async {
    return await profileRepository.updateProfileFcmToken(profile);
  }
}