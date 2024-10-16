part of 'verification_cubit.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();
  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

final class VerificationLoading extends VerificationState {}

class SuccessVerificationUser extends VerificationState {
  // final Auth auth;
  const SuccessVerificationUser(/*{required this.auth}*/);

}
class SuccessResendOtp extends VerificationState {
  // final Auth auth;
  const SuccessResendOtp(/*{required this.auth}*/);

}
class ErrVerificationUser extends VerificationState {
  final String msg;
  const ErrVerificationUser({required this.msg});

}