part of 'upload_image_cubit.dart';

sealed class UploadImageState extends Equatable {
  const UploadImageState();
}

final class UploadImageInitial extends UploadImageState {
  @override
  List<Object> get props => [];
}
