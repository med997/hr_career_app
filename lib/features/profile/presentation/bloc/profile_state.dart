part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}
 
final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}
final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}
final class ProfileFetchedState extends ProfileState {
  final Profile profile;
  const ProfileFetchedState({required this.profile});
}

final class ProfileErrorState extends ProfileState{
  final String msg;
  const ProfileErrorState({required this.msg});
}
