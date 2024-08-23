part of 'image_loader_cubit.dart';

sealed class ImageLoaderState extends Equatable {


  ImageLoaderState();



}

final class ImageLoaderInit extends ImageLoaderState {


  ImageLoaderInit();


  @override
  List<Object?> get props => [];
}

final class ImageLoadingStatus extends ImageLoaderState{

  ImageLoadingStatus();
  @override
  List<Object?> get props => [];
}
final class ImageSuccessStatus extends ImageLoaderState{
  final ImageProvider image ;

  ImageSuccessStatus({required this.image});
  @override
  List<Object?> get props => [];

}
final class ImageErrorStatus extends ImageLoaderState{

  ImageErrorStatus();

  @override
  List<Object?> get props => [];

}