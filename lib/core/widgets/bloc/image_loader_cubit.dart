import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'image_loader_state.dart';

class ImageLoaderCubit extends Cubit<ImageLoaderState> {
  ImageLoaderCubit() : super(ImageLoaderInit());

  void loadImage(String imageUrl) async {
    emit(ImageLoadingStatus());
    print('loading');
    try {
      final imageProvider = NetworkImage(imageUrl);
      emit(ImageSuccessStatus(image: imageProvider));
      print('sucess');
    } catch (error) {
      emit(ImageErrorStatus());
      print(error);

    }
  }
}
