

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/network/network_info.dart';
import 'package:hr_career_platform/features/home/data/datasources/home_remote_datasource.dart';
import 'package:hr_career_platform/features/home/domain/entities/home.dart';
import 'package:hr_career_platform/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/exceptions.dart';

class HomeRepositoryImpl extends HomeRepository{

  final HomeRemoteDataSource homeRemoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({required this.homeRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Home>> getHomeUser()async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHome = await homeRemoteDataSource.getHomeUser();
        return Right(remoteHome);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

}