part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  ProfileState();
}

final class ProfileInitial extends ProfileState {
  Profile preProfile = Profile(
      username: '',
      phone: '',
      currentJob: '',
      email: '',
      gender: '',
      nationality: '');
  ProfileInitial();

  @override
  List<Object> get props => [preProfile];
}
final class ProfileInsertStatus extends ProfileState {
  Profile preProfile = Profile(
      username: '',
      phone: '',
      currentJob: '',
      email: '',
      gender: '',
      nationality: '');
  ProfileInsertStatus(this.preProfile);

  @override
  List<Object> get props => [preProfile];
}
