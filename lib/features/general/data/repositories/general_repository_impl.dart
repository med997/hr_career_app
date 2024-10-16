import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/general/data/datasources/general_local_datasource.dart';
import 'package:hr_career_platform/features/general/data/datasources/general_remote_datasource.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import 'package:hr_career_platform/features/general/domain/repositories/general_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class GeneralRepositoryImpl extends GeneralRepository{
  final GeneralRemoteDataSource generalRemoteDataSource;
  final GeneralLocalDataSource generalLocaleDataSource;
  final NetworkInfo networkInfo;

  GeneralRepositoryImpl({required this.generalLocaleDataSource,
    required this.generalRemoteDataSource,
    required this.networkInfo});
  @override
  Future<Either<Failure, General>> getGeneral() async {
    try{
      final localeGeneral = await generalLocaleDataSource.getCachedGenerals();
      return Right(localeGeneral);
    }
    on EmptyCacheException{
      if (await networkInfo.isConnected) {
        try {
          final remoteGeneral = await generalRemoteDataSource.getGeneral();
          generalLocaleDataSource.cacheGenerals(remoteGeneral);
          return Right(remoteGeneral);
        } on ServerException {
          return Left(ServerFailure());
        }
      }else{
        return Left(OfflineFailure());
      }
    }

  }

  @override
  Future<Either<Failure, General>> getGeneralLocal() async {
    final localeGeneral = await generalLocaleDataSource.getCachedGenerals();
    return Right(localeGeneral);
  }

}