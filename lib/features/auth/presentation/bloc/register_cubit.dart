import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyPasswordController = TextEditingController();

  TextEditingController companyConfirmPasswordController = TextEditingController();

  RegisterCubit() : super(RegisterInitial()) {
    companyNameController = TextEditingController();
    companyEmailController = TextEditingController();
    companyPhoneController = TextEditingController();
    companyAddressController = TextEditingController();
    companyPasswordController = TextEditingController();
    companyConfirmPasswordController = TextEditingController();
  }

  Future<void> insertRegisterCompany() async {
    Company companyRe = Company(
        email: companyEmailController.text,
        phone: [companyPhoneController.text],
        address: companyAddressController.text,
        nameAr: companyNameController.text,
        nameEn: companyNameController.text);
    emit(InsertRegisterCompany(companyRe));
  }

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoading());
    // final failureOrSuccess = await addAuth;
    // emit(_mapFailureOrRegisterToState(failureOrSuccess));
  }

  RegisterState _mapFailureOrRegisterToState(Either<Failure, Unit> either) {
    return either.fold(
          (failure) => RegisterErrorState(msg: _mapFailureToMessage(failure)),
          (unit) =>
          RegisterSuccess(
          ),
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
