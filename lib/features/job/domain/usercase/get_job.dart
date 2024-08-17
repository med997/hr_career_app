
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/job.dart';
import '../repositories/job_repository.dart';


class GetJobUserCase {
  final JobRepository repository;

  GetJobUserCase(this.repository);

  Future<Either<Failure, List<Job>>> callTen() async {
    return await repository.getLastTen();
  }
  Future<Either<Failure, List<Job>>> callAll() async {
    return await repository.getAllJob();
  }
}