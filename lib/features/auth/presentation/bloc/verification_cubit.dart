import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usecases/signup_use_case.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final SignupUseCase signupUseCase;

  VerificationCubit({required this.signupUseCase}) : super(VerificationInitial()) ;


  Future<void> verifyUser(String token,String email) async {
    emit(VerificationLoading());


    final failureOrSuccess = await signupUseCase.signupWithOtp(token,email);

    emit(_mapFailureOrAuthToState(failureOrSuccess));

  }
  Future<void> resendOtp(String email)  async {
    emit(VerificationLoading());
    final failureOrSuccess = await signupUseCase.resendOtp(email);
    emit(_mapResendOtpToState(failureOrSuccess));
  }


  VerificationState _mapFailureOrAuthToState(Either<Failure,Unit> either) {
    return either.fold(
          (failure) => ErrVerificationUser(msg: _mapFailureToMessage(failure)),
          (_) => const SuccessVerificationUser(),
    );
  }

  VerificationState _mapResendOtpToState(Either<Failure,Unit> either) {
    return either.fold(
          (failure) => ErrVerificationUser(msg: _mapFailureToMessage(failure)),
          (_) => const SuccessResendOtp(),
    );
  }


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (EmptyCacheFailure):
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Something want wrong .. try again";
    }
  }

}
