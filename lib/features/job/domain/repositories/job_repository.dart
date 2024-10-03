import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/job.dart';

abstract class JobRepository {
  Future<Either<Failure, List<Job>>> getAllJob();
  Future<Either<Failure, List<Job>>> getLastTen();
  Future<Either<Failure, Job>> addJob(Job job);
  Future<Either<Failure, Job>> updateJob(Job job);
 Future<Either<Failure, List<Job>>> getSearchJob( companyId, categoryStr, nationalitiesStr);
}
