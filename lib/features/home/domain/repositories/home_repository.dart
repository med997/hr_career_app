import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/home/domain/entities/home.dart';
import '../../../../core/error/failures.dart';


abstract class HomeRepository {
  Future<Either<Failure, Home>> getHomeUser();
}
