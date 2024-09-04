part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool isDisabled ;
  ProfileState({required this.isDisabled});

  ProfileState copyWith({bool? isDisabled}){
    return ProfileState(isDisabled: isDisabled ?? this.isDisabled);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isDisabled];


}

final class ProfileInitial extends ProfileState {
  Profile preProfile = Profile(
      username: '',
      phone: '',
      currentJob: '',
      email: '',
      gender: '',
      nationality: '');
  ProfileInitial() : super(isDisabled: false);

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
  ProfileInsertStatus(this.preProfile) : super(isDisabled: false);

  @override
  List<Object> get props => [preProfile];
}
