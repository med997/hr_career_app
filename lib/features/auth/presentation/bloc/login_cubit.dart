import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPasswordController = TextEditingController();


  LoginCubit() : super(LoginInitial()) {
    userEmailController = TextEditingController();
    userPasswordController = TextEditingController();

    companyEmailController = TextEditingController();
    companyPasswordController = TextEditingController();
  }

  Future<void> insertLoginUser() async {
    Profile userLo = Profile(
        username: '',
        phone: '',
        currentJob: '',
        email: userEmailController.text,
        gender: '');
    emit(InsertLoginUser(userLo));
  }


  Future<void> insertLoginCompany() async {
    Profile companyLo = Profile(
        username: '',
        phone: '',
        currentJob: '',
        email: companyEmailController.text,
        gender: '');
    emit(InsertLoginCompany(companyLo));
  }
}
