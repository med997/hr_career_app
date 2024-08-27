part of 'register_cubit.dart';


sealed class RegisterState extends Equatable{
  const RegisterState();
  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  // final AuthEntity user;
  // RegisterSuccess(this.auth);
}

final class RegisterErrorState extends RegisterState {
  final String msg;
  const RegisterErrorState({required this.msg});
}