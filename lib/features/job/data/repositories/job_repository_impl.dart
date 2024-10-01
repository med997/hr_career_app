
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/job/data/models/job_model.dart';


import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/network/job_remote_datasource.dart';

typedef DeleteOrUpdateOrAddJob = Future<Job> Function();

class JobRepositoryImpl extends JobRepository {
  final JobRemoteDataSource jobRemoteDataSource;
  final NetworkInfo networkInfo;

  JobRepositoryImpl(
      {required this.jobRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Job>> addJob(Job job) async {
    return await _getMessage(() => jobRemoteDataSource.addJob(JobModel.fromJob(job)));
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
  Future<Either<Failure, Job>> updateJob(Job job) async {
    return await _getMessage(() => jobRemoteDataSource.updateJob(JobModel.fromJob(job)));
  }

  Future<Either<Failure, Job>> _getMessage(
      DeleteOrUpdateOrAddJob deleteOrUpdateOrInsertAccount) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob =  await deleteOrUpdateOrInsertAccount();
        return  Right(remoteJob);
      }on ServerException catch (e) {
        return Left(ServerFailure(messageServer:e.message??''));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getSearchJob(  companyId,  category,  nationalities ) async{
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await jobRemoteDataSource.getSearchJobs(
            companyId,
            category,
          nationalities
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
