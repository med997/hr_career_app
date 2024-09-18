part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {}


class SuccessLoginUser extends LoginState {
  final Auth auth;
  const SuccessLoginUser({required this.auth});

}
class CurrentUserStatus extends LoginState {
  final Auth auth;
  const CurrentUserStatus({required this.auth});

}
class NoLoginUser extends LoginState {
  final String msg;
  const NoLoginUser({required this.msg});
  @override
  List<Object> get props => [msg];

}
class ErrLoginUser extends LoginState {
  final String msg;
  const ErrLoginUser({required this.msg});
  @override
  List<Object> get props => [msg];
}

