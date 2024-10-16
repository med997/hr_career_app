import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/company/data/datasources/company_remote_datasource.dart';
import 'package:hr_career_platform/features/company/data/models/company_model.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/company/domain/repositories/company_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

typedef DeleteOrUpdateOrAddCompany = Future<Company> Function();

class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyRemoteDatasource companyRemoteDatasource;
  final NetworkInfo networkInfo;

  CompanyRepositoryImpl(
      {required this.networkInfo, required this.companyRemoteDatasource});

  @override
  Future<Either<Failure, Company>> getCompanyByUuid(String uuid) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCompany =
            await companyRemoteDatasource.getCompanyByUuid(uuid);
        return Right(remoteCompany);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Company>> getCompanyProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCompanyProfile = await companyRemoteDatasource.getCompany();
        return Right(remoteCompanyProfile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Company>> updateCompany(Company company) async {
    return await _getMessage(() => companyRemoteDatasource
        .updateCompany(CompanyModel.fromCompany(company)));
  }

  Future<Either<Failure, Company>> _getMessage(
      DeleteOrUpdateOrAddCompany deleteOrUpdateOrAddCompany) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCompanyProfile = await deleteOrUpdateOrAddCompany();
        return Right(remoteCompanyProfile);
      } on ServerException catch (e) {
        return Left(ServerFailure(messageServer: e.message ?? ''));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Company>> uploadImageCompany(
      dynamic path, String id) async {
    return await _getMessage(
        () => companyRemoteDatasource.uploadImageCompany(path, id));
  }

  @override
  Future<Either<Failure, Company>> updateCompanyFcmToken(
      String uuid, String fcmToken) async {
    return await _getMessage(
        () => companyRemoteDatasource.updateCompanyFcmToken(uuid, fcmToken));
  }
}
