import 'package:unsplash_sample/bloc/search_image/search_image_bloc.dart';
import 'package:unsplash_sample/bloc/search_image/search_image_state.dart';
import 'package:unsplash_sample/key.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/api_methods.dart';
import 'package:unsplash_sample/utils/urls.dart';



class ImageSearchEvent{
  final ApiMethods _apiMethods = GetImageList();
  final int page;
  final String query;

  ImageSearchEvent(this.page, this.query);


  Future<SearchImageListState> applyAsync({SearchImageListState currentState, bloc}) async {
    bloc.isFetching = true;
    int _page = 0;
    List<Photo> imageListData  = [];
    if(currentState is SearchImageLoaded){
      _page = currentState.page + 1;
      imageListData = currentState.photos;
    }
    try{
      List<Photo> tempImageListData = await _apiMethods.getResponseFromUrl(ApiUrls.SEARCH_IMAGE,{
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
