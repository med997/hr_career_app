import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/payment/domain/usecases/add_payment.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../../job/presentation/bloc/curd_job_cubit.dart';
import '../../domain/entities/payment.dart';

part 'payment_curd_state.dart';

class PaymentCurdCubit extends Cubit<PaymentCurdState> {
  final AddPaymentUseCase addPaymentUseCase;
  PaymentCurdCubit({required this.addPaymentUseCase}) : super(CurdPaymentInitial());


  PaymentCurdState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
          (failure) => ErrorCurdPaymentState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageCurdPaymentState(message: message),
    );
  }
  Future<void> insertPayment(Payment payment) async {
    emit(LoadingCurdPaymentState());
    final failureOrSuccess = await addPaymentUseCase.call(payment);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'insertDone'));
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}
