
import 'package:dartz/dartz.dart';


import 'package:hr_career_platform/features/job/domain/repositories/job_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/job.dart';

class SearchJobsUserCase{
  final JobRepository repository;

  SearchJobsUserCase({required this.repository});


  Future<Either<Failure, List<Job>>> call(int  companyId,String category,nationalities ) async {
    return await repository.getSearchJob( companyId,category,nationalities);
  }

}