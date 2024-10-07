
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/job.dart';
import '../repositories/job_repository.dart';


class AddApplianceJobUseCase {
  final JobRepository repository;

  AddApplianceJobUseCase(this.repository);


  Future<Either<Failure, int>> call(int jobId, String profileId ) async {
    return await repository.addApplianceJob(jobId,profileId);
  }
}