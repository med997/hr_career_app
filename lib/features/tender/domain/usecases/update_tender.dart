import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/tender.dart';
import '../repositories/tender_repository.dart';

class UpdateTenderUserCase {
  final TenderRepository repository;

  UpdateTenderUserCase(this.repository);

  Future<Either<Failure, Tender>> call(Tender tender) async {
    return await repository.updateTender(tender);
  }
}
