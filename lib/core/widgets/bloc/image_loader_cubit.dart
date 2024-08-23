import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_loader_state.dart';

class ImageLoaderCubit extends Cubit<ImageLoaderState> {
  ImageLoaderCubit() : super(ImageLoaderSuccess());

  Future<void> imageLoadErr() async {
    print('imageLoadErr');
    emit(ImageLoaderError());
  }
}
