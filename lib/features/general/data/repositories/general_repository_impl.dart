import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/general/data/datasources/general_remote_datasource.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import 'package:hr_career_platform/features/general/domain/repositories/general_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class GeneralRepositoryImpl extends GeneralRepository{
  final GeneralRemoteDataSource generalRemoteDataSource;
  final NetworkInfo networkInfo;

  GeneralRepositoryImpl({required this.generalRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, General>> getGeneral() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGeneral = await generalRemoteDataSource.getGeneral();
        return Right(remoteGeneral);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

}