import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());
}
