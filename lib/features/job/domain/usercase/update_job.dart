import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/job.dart';
import '../repositories/job_repository.dart';


class UpdateJob {
  final JobRepository repository;

  UpdateJob(this.repository);

  Future<Either<Failure, Unit>> call(Job job) async {
    return await repository.updateJob(job);
  }
}