import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/usecases/update_profile.dart';
import 'package:hr_career_platform/features/profile/domain/usecases/update_profile_fcm_token.dart';

import '../../../../core/strings/failures.dart';

part 'curd_profile_state.dart';

class CurdProfileCubit extends Cubit<CurdProfileState> {
  final UpdateProfileFcmToken updateProfileFcmToken;
  final UpdateProfileUseCase updateProfileUseCase;

  CurdProfileCubit(
      {required this.updateProfileFcmToken, required this.updateProfileUseCase})
      : super(CurdProfileInitial());

  Future<void> updateProfile(Map<String, dynamic>? value) async {
    if (value!['id'] == null) {
      emit(const ErrorCurdProfileState(message: "ID cannot be null"));
      return;
    }
    emit(LoadingCurdProfileState());
    Profile profile = Profile(
      id: value['id'],
      address: value['address'] ,
      phone: value['phone'] ,
      currentJob: value['currentJob'] ,
      fullName: value['fullName'] ,
      secondaryPhone: value['secondaryPhone'] ,
      gender: value['gender'] ,
      fullNameAr: value['fullNameAr'] ,
      major: value['major'] ,
      dob: value['dob'],
      email: value['email'],
    );
    final failureOrSuccess = await updateProfileUseCase.call(profile);
    emit(_eitherDoneMessageOrErrorState2(failureOrSuccess, 'updateDone'));
  }

  Future<void> uploadImageProfile(File file,String id) async {
    emit(LoadingCurdProfileState());
    final failureOrSuccess = await updateProfileUseCase.uploadImageProfile(file,id);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }

  Future<void> updateProfileFcm(Profile profile) async {
    if (profile.id == null) {
      emit(const ErrorCurdProfileState(message: "ID cannot be null"));
      return;
    }
    emit(LoadingCurdProfileState());
    final failureOrSuccess =
        await updateProfileFcmToken.updateFcmToken(profile);
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

  CurdProfileState _eitherDoneMessageOrErrorState2(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorCurdProfileState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageCurdProfileState(message: message,),
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
