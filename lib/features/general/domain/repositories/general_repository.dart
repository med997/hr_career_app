import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import '../../../../core/error/failures.dart';


abstract class GeneralRepository {
  Future<Either<Failure, General>> getGeneral();
  Future<Either<Failure, General>> getGeneralLocal();
}
