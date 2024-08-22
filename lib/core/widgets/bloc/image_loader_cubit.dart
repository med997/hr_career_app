import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_loader_state.dart';

class ImageLoaderCubit extends Cubit<ImageLoaderState> {
  ImageLoaderCubit() : super(const ImageLoaderState(imageLoadErr: false));

  void imageLoadErr(bool hasErr){
    if(hasErr)
    emit(ImageLoaderError(imageLoadErr: true));
    else emit(ImageLoaderSuccess(imageLoadErr: false));
  }
}
