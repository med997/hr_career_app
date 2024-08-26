import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> insertProfile(Profile profile) async {
    emit(ProfileInsertStatus(profile: profile));
    print('cubit ${profile.nationality}');

  }

}
