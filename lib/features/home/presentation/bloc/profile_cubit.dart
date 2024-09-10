
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  ProfileCubit() : super(ProfileInitial());

  void uploadFile(String fileName) {
    emit(FileUploadSuccess(fileName));
  }

  Future<void> isDisabled() async {
    emit(state.copyWith(isDisabled: !state.isDisabled));
  }
}