import 'package:unsplash_sample/model/photo_model.dart';

abstract class SearchImageListState {
  const SearchImageListState();
}

class SearchImageError extends SearchImageListState {}

class SearchImageInitialState extends SearchImageListState{}

class SearchImagePagination extends SearchImageListState{}

class SearchImageLoaded extends SearchImageListState{
  final List<Photo> photos;
  final int page;

  SearchImageLoaded(this.photos, this.page);

  SearchImageLoaded copyWith(List<Photo> photos) {
    return SearchImageLoaded(photos, page);
  }

}
