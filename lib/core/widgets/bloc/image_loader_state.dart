part of 'image_loader_cubit.dart';

sealed class ImageLoaderState extends Equatable {

   @override
   List<Object> get props => [];

 }


final class ImageLoaderError extends ImageLoaderState {
  @override
  List<Object> get props => [];
}
final class ImageLoaderSuccess extends ImageLoaderState {
  @override
  List<Object> get props => [];
}
