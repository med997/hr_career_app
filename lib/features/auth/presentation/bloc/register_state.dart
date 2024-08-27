part of 'register_cubit.dart';


sealed class RegisterState extends Equatable {
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

class InsertRegisterCompany extends RegisterState {
  Company companyRe = Company(
      email: '',
      phone: [],
      address: '',
      nameAr: '',
      nameEn: '');

  InsertRegisterCompany(this.companyRe);
}

class InsertRegisterUser extends RegisterState {
  Profile userRe = Profile(
      username:'',
      phone: '',
      currentJob: '',
      email: '',
      gender: '',
  );
  InsertRegisterUser(this.userRe);

}

final class RegisterErrorState extends RegisterState {
  final String msg;

  const RegisterErrorState({required this.msg});
}