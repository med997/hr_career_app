import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/usecases/update_profile.dart';
import 'package:hr_career_platform/features/profile/domain/usecases/update_profile_fcm_token.dart';

import '../../../../core/strings/failures.dart';
import '../../../../core/util/const_val.dart';

part 'curd_profile_state.dart';

class CurdProfileCubit extends Cubit<CurdProfileState> {
  final UpdateProfileFcmToken updateProfileFcmToken;
  final UpdateProfileUseCase updateProfileUseCase;

  CurdProfileCubit(
      {required this.updateProfileFcmToken, required this.updateProfileUseCase})
      : super(CurdProfileInitial());

  Future<void> updateProfile(Map<String, dynamic>? value,String id) async {

    emit(LoadingCurdProfileState());
    final failureOrSuccess = await updateProfileUseCase.updateProfile(value,id);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }
  Future<void> updateProfileExp(Map<String, dynamic>? value,String id) async {
    emit(LoadingExpProfileState());

    final failureOrSuccess = await updateProfileUseCase.updateProfileExp(value, id);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }
  Future<void> updateProfileEdc(Map<String, dynamic>? value,String id) async {
    emit(LoadingEduProfileState());

    final failureOrSuccess = await updateProfileUseCase.updateProfileExp(value, id);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }

  Future<void> uploadImageProfile(File file,String id) async {
    emit(LoadingCurdProfileState());
    final failureOrSuccess = await updateProfileUseCase.uploadImageProfile(file,id);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }

  Future<void> updateProfileFcm(String uuid , List<String>? fcmToken) async {
    if (uuid.isEmpty) {
      emit(const ErrorCurdProfileState(message: "ID cannot be null"));
      return;
    }
    emit(LoadingCurdProfileState());
    final failureOrSuccess =
        await updateProfileFcmToken.updateFcmToken(uuid, fcmToken);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateFcmDone'));
  }

  CurdProfileState _eitherDoneMessageOrErrorState(
      Either<Failure, Profile> either, String message) {
    return either.fold(
      (failure) => ErrorCurdProfileState(
        message: _mapFailureToMessage(failure),
      ),
      (profile) => MessageCurdProfileState(message: message, profile: profile),
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
