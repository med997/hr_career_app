import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class AddPaymentUseCase {
  final PaymentRepository repository;

  AddPaymentUseCase({required this.repository});


  Future<Either<Failure, Unit>> call(Payment payment) async {
    return await repository.addPayment(payment);
  }

}