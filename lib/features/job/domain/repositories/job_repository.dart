import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/job.dart';

abstract class JobRepository {
  Future<Either<Failure, List<Job>>> getAllJob();
  Future<Either<Failure, List<Job>>> getLastTen();
  Future<Either<Failure, Unit>> addJob(Job job);
  Future<Either<Failure, Unit>> updateJob(Job job);
}
