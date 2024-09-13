part of 'profile_cubit.dart';

class ProfileState extends Equatable {
    final bool isEditing ;
  ProfileState({this.isEditing = false});
  @override
  List<Object> get props => [isEditing];
}

class FileUploadSuccess extends ProfileState {
  final String fileName;
   FileUploadSuccess(this.fileName) : super(isEditing: false);
  @override
  List<Object> get props => [fileName,isEditing];
}

final class ProfileInitial extends ProfileState {
  ProfileInitial() : super(isEditing: false);
  @override
  List<Object> get props => [isEditing];
}

class ProfileEditing extends ProfileState {
   ProfileEditing() : super(isEditing: true);
}