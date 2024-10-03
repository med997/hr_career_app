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

  RegisterCubit({required this.signupUseCase}) : super(RegisterInitial()) ;

  Future<void> registerUser(int selectedIndex, Map<String,dynamic>? value) async {
    emit(RegisterLoading());

    UsrType usrType = selectedIndex == 0 ? UsrType.user : UsrType.company;
    Auth auth;
    if (usrType == UsrType.user) {
      auth = Auth(
          userType:UsrType.user ,
          email: value!['email'],
          password: value['password'],
          profile: Profile(
              fullName: value['fullName'],
              phone: value['phone'],
              email: value['email']));
    } else {

       auth = Auth(
           userType: UsrType.company,
           email: value!['email'],
           password: value['password'],
           company: Company(
               nameEn: value['companyNameEn'],
               nameAr: value['companyNameAr'],
               phone: value['phone'],
               email: value['email'],
               city: value['city'],
             govRegNo: value['govRegNo'],
               address: value['address'],),);
     }


    final failureOrSuccess = await signupUseCase.call(auth);

    emit(_mapFailureOrAuthToState(failureOrSuccess));

  }
    RegisterState _mapFailureOrAuthToState(Either<Failure,Auth> either) {
      return either.fold(
            (failure) => ErrRegisterUser(msg: _mapFailureToMessage(failure)),
            (auth) => SuccessRegisterUser(auth  : auth),
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
