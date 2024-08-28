part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

final class InsertLoginUser extends LoginState {
  Profile userLo = Profile(
      username: '',
      phone: '',
      currentJob: '',
      email: '',
      gender: '');
  InsertLoginUser(this.userLo);
  @override
  List<Object?> get props => [];
}

final class InsertLoginCompany extends LoginState {
  Profile companyLo = Profile(
      username: '',
      phone: '',
      currentJob: '',
      email: '',
      gender: '');
  InsertLoginCompany(this.companyLo);

  @override
  List<Object?> get props => [];
}
