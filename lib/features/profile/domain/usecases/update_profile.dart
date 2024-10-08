import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/failures.dart';
class UpdateProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase(this.profileRepository);

  Future<Either<Failure, Profile>> updateProfile(Profile profile) async {
    return await profileRepository.updateProfile(profile);
  }
  Future<Either<Failure, Profile>> uploadImageProfile(File file,String id) async {
    return await profileRepository.uploadImageProfile(file, id);
  }
}