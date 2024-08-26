part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {

  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
final class ProfileInsertStatus extends ProfileState {
  final Profile? profile;

  ProfileInsertStatus({ this.profile});

  @override
  List<Object> get props => [];
}
