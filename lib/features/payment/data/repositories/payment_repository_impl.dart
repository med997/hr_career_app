import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/payment/domain/repositories/payment_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/payment_remote_datasource.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentRemoteDataSource paymentRemoteDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl({required this.paymentRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Package>>> getPackages(PkgType type)async {
    if (await networkInfo.isConnected) {
      try {
        final remotePkg = await paymentRemoteDataSource.getPackages(type);
        return Right(remotePkg);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  }
