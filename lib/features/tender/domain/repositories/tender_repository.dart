import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/tender/domain/entities/tender.dart';

import '../../../../core/error/failures.dart';

abstract class TenderRepository {
  Future<Either<Failure, Tender>> addTender(Tender tender);
  Future<Either<Failure, Tender>> updateTender(Tender tender);
}
