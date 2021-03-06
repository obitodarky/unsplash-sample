import 'package:unsplash_sample/bloc/search_image/search_image_state.dart';
import 'package:unsplash_sample/key.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/api_methods.dart';
import 'package:unsplash_sample/utils/urls.dart';

abstract class ImageSearchEvent {
  Future<SearchImageListState> applyAsync({SearchImageListState currentState, bloc});
}

class DiscoverImageSearchEvent extends ImageSearchEvent{
  final ApiMethods _apiMethods = GetImageList();
  final int page;
  final String query;

  DiscoverImageSearchEvent(this.page, this.query);

  @override
  Future<SearchImageListState> applyAsync({SearchImageListState currentState, bloc}) async {
    bloc.isFetching = true;
    try{
      List<Photo> imageListData = await _apiMethods.getSearchedImages(ApiUrls.SEARCH_IMAGE,{
        "client_id": ApiKey.CLIENT_ID,
        "page": 0,
        "query": query,
      } );
      bloc.isFetching = false;
      return SearchImageLoaded(imageListData, 0);
    } catch(error,stacktrace) {
      print("$error $stacktrace");
      return SearchImageError();
    }
  }
}

class SearchImagePaginationEvent extends ImageSearchEvent{
  final ApiMethods _apiMethods = GetImageList();
  final String query;

  SearchImagePaginationEvent(this.query);

  @override
  Future<SearchImageListState> applyAsync({SearchImageListState currentState, bloc}) async {
    int _page = 0;
    List<Photo> imageListData  = [];
    if(currentState is SearchImageLoaded){
      _page = currentState.page + 1;
      imageListData = currentState.photos;
    }
    try{
      List<Photo> tempImageListData = await _apiMethods.getSearchedImages(ApiUrls.SEARCH_IMAGE,{
        "client_id": ApiKey.CLIENT_ID,
        "page": _page,
        "query": query,
      } );
      imageListData.addAll(tempImageListData);
      bloc.isFetching = false;
      return SearchImageLoaded(imageListData, _page);
    } catch(error,stacktrace) {
      print("$error $stacktrace");
      return SearchImageError();
    }
  }

}
