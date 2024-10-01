
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/job.dart';
import '../repositories/job_repository.dart';


class AddJobUserCase {
  final JobRepository repository;

  AddJobUserCase(this.repository);


  Future<Either<Failure, Job>> call(Job job) async {
    return await repository.addJob(job);
  }
}