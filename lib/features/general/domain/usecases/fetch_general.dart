import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/general.dart';
import '../repositories/general_repository.dart';

class GetGeneralUseCase {
  final GeneralRepository repository;

  GetGeneralUseCase(this.repository);

  Future<Either<Failure, General>> call() async {
    return await repository.getGeneral();
  }
  Future<Either<Failure, General>> callLocal() async {
    return await repository.getGeneralLocal();
  }
}
