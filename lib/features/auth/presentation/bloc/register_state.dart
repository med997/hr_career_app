part of 'register_cubit.dart';


sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}



class SuccessRegisterUser extends RegisterState {
  final Auth auth;
  const SuccessRegisterUser({required this.auth});

}
class ErrRegisterUser extends RegisterState {
  final String msg;
  const ErrRegisterUser({required this.msg});

}
