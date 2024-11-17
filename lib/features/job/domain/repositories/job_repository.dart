import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/job.dart';

abstract class JobRepository {
  Future<Either<Failure, List<Job>>> getAllJob(String? searchVal,String? nat,String? city,String? category);
  Future<Either<Failure, List<Job>>> getLastTen();
  Future<Either<Failure, Job>> addJob(Job job);
  Future<Either<Failure, Job>> updateJob(Job job);
  Future<Either<Failure, List<Job>>> getSearchJob(int companyId, String categoryStr, String? nationalitiesStr);
  Future<Either<Failure, int>> addApplianceJob(int jobId, String profileId);
  Future<Either<Failure, int>> updateApplyJobState(int applianceId,String applyState);
  Future<Either<Failure, List<Job>>> getAllJobsByCompany(String companyId);
  Future<Either<Failure, List<Job>>> getAllActiveJobsByCompany(String companyId);

}
