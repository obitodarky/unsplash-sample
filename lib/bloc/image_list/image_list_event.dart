import 'package:unsplash_sample/bloc/image_list/image_list_state.dart';
import 'package:unsplash_sample/bloc/image_list/image_list_bloc.dart';
import 'package:unsplash_sample/key.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/api_methods.dart';
import 'package:unsplash_sample/utils/urls.dart';

abstract class ImageEvent{
  Future<ImageListState> applyAsync({ImageListState currentState, ImageListBloc bloc});
}

class ImageFetched extends ImageEvent {
 final ApiMethods _apiMethods = GetImageList();
 final int page;
 ImageFetched(this.page);

  @override
  Future<ImageListState> applyAsync({ImageListState currentState, ImageListBloc bloc}) async {
    bloc.isFetching = true;
    int _page = 0;
    List<Photo> imageListData  = [];
    if(currentState is ImageLoaded){
      _page = currentState.page + 1;
      imageListData = currentState.photos;
    }
    try{
      List<Photo> tempImageListData = await _apiMethods.getResponseFromUrl(ApiUrls.GET_IMAGE, {
        "client_id": ApiKey.CLIENT_ID,
        "page": _page
      });
      imageListData.addAll(tempImageListData);
      bloc.isFetching = false;
      return ImageLoaded(imageListData, _page);
    } catch(error,stacktrace) {
      print("$error $stacktrace");
      return ImageError();
    }
  }
}
