part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool isDisabled ;
  ProfileState({required this.isDisabled});

  ProfileState copyWith({bool? isDisabled}){
    return ProfileState(isDisabled: isDisabled ?? this.isDisabled);
  }
  @override
  List<Object?> get props => [isDisabled];
}

class FileUploadSuccess extends ProfileState {
  final String fileName;
   FileUploadSuccess(this.fileName) : super(isDisabled: false);
  @override
  List<Object> get props => [fileName];
}

final class ProfileInitial extends ProfileState {
  ProfileInitial() : super(isDisabled: false);
  @override
  List<Object> get props => [];
}

