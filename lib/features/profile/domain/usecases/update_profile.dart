import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/failures.dart';
class UpdateProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase(this.profileRepository);

  Future<Either<Failure, Profile>> updateProfile(Map<String, dynamic>? value,String id) async {
    return await profileRepository.updateProfile(value,id);
  }
  Future<Either<Failure, Profile>> updateProfileExp(Map<String, dynamic>? value,String id) async {
    return await profileRepository.updateProfileExp(value,id);
  }
  Future<Either<Failure, Profile>> updateProfileEdc(Map<String, dynamic>? value,String id) async {
    return await profileRepository.updateProfileEdc(value,id);
  }
  Future<Either<Failure, Profile>> uploadImageProfile(File file,String id) async {
    return await profileRepository.uploadImageProfile(file, id);
  }
}