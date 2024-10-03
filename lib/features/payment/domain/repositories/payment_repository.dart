import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/payment/domain/entities/payment.dart';

import '../entities/package.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<Package>>> getPackages(PkgType type);
  Future<Either<Failure, Unit>> addPayment(Payment payment);

}
