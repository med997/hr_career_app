
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/job/data/models/job_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/network/job_remote_datasource.dart';

typedef DeleteOrUpdateOrAddJob = Future<Unit> Function();

class JobRepositoryImpl extends JobRepository {
  final JobRemoteDataSource jobRemoteDataSource;
  final NetworkInfo networkInfo;

  JobRepositoryImpl(
      {required this.jobRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addJob(Job job) {
    // TODO: implement addJob
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Job>>> getAllJob() async{
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await jobRemoteDataSource.getAllJobs();
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getLastTen() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await jobRemoteDataSource.getLastJobs();
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateJob(Job job) {
    // TODO: implement updateJob
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Job>>> getSearchJob( int companyId, String categoryStr, String nationalitiesStr ) async{
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await jobRemoteDataSource.getSearchJobs(
            companyId,
            categoryStr,
          nationalitiesStr
        );
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}
