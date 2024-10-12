import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/profile_model.dart';
typedef DeleteOrUpdateOrAddProfile = Future<Profile> Function();
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(
      {required this.networkInfo, required this.profileRemoteDatasource});

  @override
  Future<Either<Failure, Profile>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDatasource.getUser();
        return Right(remoteProfile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUserByUuid(String uuid)  async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDatasource.getUserByUuid(uuid);
        return Right(remoteProfile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfileFcmToken(String uuid ,  List<String>? fcmToken)async {

  return await _getMessage(() => profileRemoteDatasource.updateProfileFcmToken(uuid, fcmToken));
}
  @override
  Future<Either<Failure, Profile>> uploadImageProfile(File file,String id)async {
  return await _getMessage(() => profileRemoteDatasource.uploadImageProfile(file,id));
}

Future<Either<Failure, Profile>> _getMessage(
    DeleteOrUpdateOrAddProfile deleteOrUpdateOrAddProfile) async {
  if (await networkInfo.isConnected) {
    try {
      final response =await deleteOrUpdateOrAddProfile();
      return  Right(response);
    }on ServerException catch (e) {
      return Left(ServerFailure(messageServer:e.message??''));
    }
  } else {
    return Left(OfflineFailure());
  }
}

  @override
  Future<Either<Failure, List<Profile>>> getAppliance(String profileId) async{
    if (await networkInfo.isConnected) {
      try {
        final remoteAppliance = await profileRemoteDatasource.getAppliance(profileId);
        return Right(remoteAppliance);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(Profile profile) async {
    return await _getMessage(() => profileRemoteDatasource.updateProfile(
        ProfileModel.fromProfile(profile)));
  }
}
