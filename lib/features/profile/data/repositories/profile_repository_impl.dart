import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/profile_model.dart';

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
}
