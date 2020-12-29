import 'package:unsplash_sample/model/photo_model.dart';

abstract class ImageListState {
  const ImageListState();
}

class InitialPhotoListState extends ImageListState {}

class ImageError extends ImageListState {}

class ImageLoaded extends ImageListState {
  final List<Photo> photos;
  final int page;

  ImageLoaded(this.photos, this.page);

  ImageLoaded copyWith(List<Photo> photos) {
    return ImageLoaded(photos, page);
  }
}
