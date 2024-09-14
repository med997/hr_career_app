import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/failures.dart';

class FetchProfileUserCase {
  final ProfileRepository profileRepository;

  FetchProfileUserCase(this.profileRepository);

  Future<Either<Failure, Profile>> getUserProfile() async {
    return await profileRepository.getUserProfile();
  }
  Future<Either<Failure, Profile>> getUserByUuid(String uuid) async {
    return await profileRepository.getUserByUuid(uuid );
  }
}
