import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/strings/failures.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/auth/domain/usecases/fetch_auth.dart';
import 'package:hr_career_platform/features/auth/domain/usecases/login_use_case.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final FetchAuthUseCase fetchAuthUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.fetchAuthUseCase,
  }) : super(LoginInitial());

  Future<void> loginUser(int selectedIndex, Map<String, dynamic>? value) async {
    emit(LoginLoading());

    UsrType usrType = selectedIndex == 0 ? UsrType.user : UsrType.company;
    Auth auth;
    print(value);
    if (usrType == UsrType.user) {
      auth = Auth(
          userType: UsrType.user,
          email: value!['email'],
          password: value['password']);
    } else {
      auth = Auth(
          userType: UsrType.company,
          email: value!['email'],
          password: value['password']);
    }

    final failureOrSuccess = await loginUseCase.call(auth);

    emit(_mapFailureOrAuthToState(failureOrSuccess));
  }

  Future<void> checkLoginStatus() async {
    final failureOrAuth = await fetchAuthUseCase.call();
    emit(_mapCheckAuthToState(failureOrAuth));
  }

  LoginState _mapFailureOrAuthToState(Either<Failure, Auth> either) {
    return either.fold(
      (failure) => ErrLoginUser(msg: _mapFailureToMessage(failure)),
      (auth) => SuccessLoginUser(auth: auth),
    );
  }

  LoginState _mapCheckAuthToState(Either<Failure, Auth> either) {
    return either.fold(
      (failure) {
        print(failure.runtimeType);
        return NoLoginUser(msg: _mapFailureToMessage(failure));
      },
      (auth) => CurrentUserStatus(auth: auth),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case (ServerFailure):
        return (failure as ServerFailure).messageServer ??
            SERVER_FAILURE_MESSAGE;
      case (EmptyCacheFailure):
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case (AuthFailure):
        return failure.message;
      case (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Something want wrong .. try again";
    }
  }
}
