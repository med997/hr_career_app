import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/network/network_info.dart';
import 'package:hr_career_platform/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hr_career_platform/features/auth/data/models/auth_model.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authRemoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, Auth>> login(Auth auth) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Auth>> signup(Auth auth) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await authRemoteDatasource.signup(auth);
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
