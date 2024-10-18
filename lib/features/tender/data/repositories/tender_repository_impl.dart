import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/tender/data/datasources/tender_remote_datasource.dart';
import 'package:hr_career_platform/features/tender/domain/entities/tender.dart';
import 'package:hr_career_platform/features/tender/domain/repositories/tender_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/tender_model.dart';

typedef DeleteOrUpdateOrAddTender = Future<Tender> Function();

class TenderRepositoryImpl extends TenderRepository{
  final TenderRemoteDataSource tenderRemoteDataSource;
  final NetworkInfo networkInfo;

  TenderRepositoryImpl({required this.networkInfo, required this.tenderRemoteDataSource});
  @override
  Future<Either<Failure, Tender>> addTender(Tender tender) async{
    return await _getMessage(() => tenderRemoteDataSource.addTender(TenderModel.fromTender(tender)));

  }
  Future<Either<Failure, Tender>> _getMessage(
      DeleteOrUpdateOrAddTender deleteOrUpdateOrInsertTender) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTender =  await deleteOrUpdateOrInsertTender();
        return  Right(remoteTender);
      }on ServerException catch (e) {
        return Left(ServerFailure(messageServer:e.message??''));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}