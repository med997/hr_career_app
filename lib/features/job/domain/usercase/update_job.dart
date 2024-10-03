import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/job.dart';
import '../repositories/job_repository.dart';


class UpdateJob {
  final JobRepository repository;

  UpdateJob(this.repository);

  Future<Either<Failure, Job>> call(Job job) async {
    return await repository.updateJob(job);
  }
}