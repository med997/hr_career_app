import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/home/domain/entities/home.dart';
import '../../../../core/error/failures.dart';
import '../../../job/domain/entities/job.dart';


abstract class HomeRepository {
  Future<Either<Failure, Home>> getHomeUser();
  Future<Either<Failure, List<Job>>> getHomeCompany(String companyId);
}
