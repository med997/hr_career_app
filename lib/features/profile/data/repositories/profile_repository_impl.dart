import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/profile_model.dart';
typedef DeleteOrUpdateOrAddProfile = Future<Profile> Function();
typedef DeleteOrUpdateOrAddProfile2 = Future<Unit> Function();
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
  Future<Either<Failure, Profile>> updateProfileFcmToken(Profile profile)async {

  return await _getMessage(() => profileRemoteDatasource.updateProfileFcmToken(
      ProfileModel.fromProfile(profile)));
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

Future<Either<Failure, Unit>> _getMessage2(
    DeleteOrUpdateOrAddProfile2 deleteOrUpdateOrAddProfile) async {
  if (await networkInfo.isConnected) {
    try {
      await deleteOrUpdateOrAddProfile();
      return  Right(unit);
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
  Future<Either<Failure, Unit>> updateProfile(Profile profile) async {
    return await _getMessage2(() => profileRemoteDatasource.updateProfile(
        ProfileModel.fromProfile(profile)));
  }
}
