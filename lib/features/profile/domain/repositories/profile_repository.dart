import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getUserProfile();
  Future<Either<Failure, Profile>>  getUserByUuid(String uuid);
  Future<Either<Failure, Profile>>  updateProfileFcmToken(String uuid ,  List<String>? fcmToken);
  Future<Either<Failure, Profile>>  updateProfile(Map<String, dynamic>? value,String id);
  Future<Either<Failure, Profile>>  updateProfileExp(Map<String, dynamic>? value,String id);
  Future<Either<Failure, Profile>>  updateProfileEdc(Map<String, dynamic>? value,String id);
  Future<Either<Failure, List<Profile>>> getAppliance(String profileId);
  Future<Either<Failure, Profile>> uploadImageProfile(dynamic file,String id);
  Future<Either<Failure, Profile>> uploadPdf(dynamic pdf,String id);
}
