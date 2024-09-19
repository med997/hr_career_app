import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/network/network_info.dart';
import 'package:hr_career_platform/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hr_career_platform/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hr_career_platform/features/auth/data/models/auth_model.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authLocalDataSource, required this.authRemoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, Auth>> login(Auth auth)async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authRemoteDatasource.login(auth);
        authLocalDataSource.cacheAuths(response);
        return Right(response);
      } on ServerException catch(err){
        return Left(ServerFailure(messageServer:err.message));
      }catch(e) {
        return Left(OfflineFailure());
      }
    } else {
      return Left(OfflineFailure());
    }

  }

  @override
  Future<Either<Failure, Auth>> signup(Auth auth) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authRemoteDatasource.signup(auth);
        authLocalDataSource.cacheAuths(response);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> getCurrentUser() async{
    try{
      final authModel = await authLocalDataSource.getCachedAuths();
      return Right(authModel);
    }on EmptyCacheException{
      return Left(EmptyCacheFailure());
      /*if (await networkInfo.isConnected) {
        try {
          final response = await authRemoteDatasource.getCurrentUserData();
          authLocalDataSource.cacheAuths(response);
          return Right(response);
        } on ServerException {
          return Left(ServerFailure());
        } on AuthException catch(error){
          // return Left(AuthFailure('${error.message}-${error.statusCode}'));
          return Left(AuthFailure(error.message));
        }catch(e) {
          return Left(OfflineFailure());
        }
      } else {
        return Left(OfflineFailure());
      }*/
    }
  }
}
