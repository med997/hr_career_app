import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/auth/domain/usecases/signup_use_case.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SignupUseCase signupUseCase;
  bool isLoading =false;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyPasswordController = TextEditingController();
  TextEditingController companyConfirmPasswordController =
      TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userConfirmPasswordController = TextEditingController();

  RegisterCubit({required this.signupUseCase}) : super(RegisterInitial()) {
    companyNameController = TextEditingController();
    companyEmailController = TextEditingController();
    companyPhoneController = TextEditingController();
    companyAddressController = TextEditingController();
    companyPasswordController = TextEditingController();
    companyConfirmPasswordController = TextEditingController();
    userNameController = TextEditingController();
    userPhoneController = TextEditingController();
    userEmailController = TextEditingController();
    userPasswordController = TextEditingController();
    userConfirmPasswordController = TextEditingController();
  }

  Future<void> registerUser(int selectedIndex) async {
    isLoading=true;
    UsrType usrType = selectedIndex == 0 ? UsrType.user : UsrType.company;
    Auth auth;
    if (usrType == UsrType.user) {
      auth = Auth(
          userType:UsrType.user ,
          email: userEmailController.text,
          password: userPasswordController.text,
          profile: Profile(
              fullName: userNameController.text,
              phone: userPhoneController.text,
              email: userEmailController.text));
    } else {
      auth = Auth(
        userType:UsrType.company ,
          email: companyEmailController.text,
          password: userPasswordController.text,
          profile: Profile(
              fullName: userNameController.text,
              phone: companyPhoneController.text,
              email: userEmailController.text));
    }

    final failureOrSuccess = await signupUseCase.call(auth);

    emit(_mapFailureOrAuthToState(failureOrSuccess));
    isLoading=false;
  }
  RegisterState _mapFailureOrAuthToState(Either<Failure,Auth> either) {
    return either.fold(
          (failure) => ErrRegisterUser(msg: _mapFailureToMessage(failure)),
          (auth) => SuccessRegisterUser(
          auth  : auth
      ),
    );
  }
/*  Future<void> insertRegisterCompany() async {
    Company companyRe = Company(
        email: companyEmailController.text,
        phone: [companyPhoneController.text],
        address: companyAddressController.text,
        nameAr: companyNameController.text,
        nameEn: companyNameController.text);
    emit(InsertRegisterUser());
  }*/

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoading());
    // final failureOrSuccess = await addAuth;
    // emit(_mapFailureOrRegisterToState(failureOrSuccess));
  }

  RegisterState _mapFailureOrRegisterToState(Either<Failure, Unit> either) {
    return either.fold(
      (failure) => RegisterErrorState(msg: _mapFailureToMessage(failure)),
      (unit) => RegisterSuccess(),
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
