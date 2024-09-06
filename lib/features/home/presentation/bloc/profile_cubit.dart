
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController currentJobController = TextEditingController();
  TextEditingController nationalityTextController = TextEditingController();
  String nationality='';

  ProfileCubit() : super(ProfileInitial()) {
    nationality = '';
    userNameController = TextEditingController();
    phoneController = TextEditingController();
    currentJobController = TextEditingController();
    nationalityTextController = TextEditingController();


  }

  void uploadFile(String fileName) {
    emit(FileUploadSuccess(fileName));
  }

  Future<void> isDisabled ()async{
    emit( state.copyWith(isDisabled: !state.isDisabled));
  }

  Future<void> insertProfile() async {
    Profile profile = Profile(
        username: userNameController.text,
        phone: phoneController.text,
        currentJob: currentJobController.text,
        secondaryPhone: '',
        email: '',
        fullName: '',
        gender: '',
        nationality: nationality);

    print('cubit ${profile.nationality}');
    emit(ProfileInsertStatus(profile));
  }
}
