part of 'image_loader_cubit.dart';

 class ImageLoaderState extends Equatable {
  final bool imageLoadErr ;
  const ImageLoaderState({required this.imageLoadErr});
  @override
  List<Object> get props => [imageLoadErr ];
}



final class ImageLoaderError extends ImageLoaderState {
  const ImageLoaderError({required super.imageLoadErr});
}
final class ImageLoaderSuccess extends ImageLoaderState {
  const ImageLoaderSuccess({required super.imageLoadErr});
}
