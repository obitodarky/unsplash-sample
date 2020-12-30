import 'package:equatable/equatable.dart';
import 'package:unsplash_sample/bloc/image_list/image_list_state.dart';
import 'package:unsplash_sample/bloc/image_list/image_list_bloc.dart';
import 'package:unsplash_sample/key.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/api_methods.dart';

abstract class ImageEvent{
  Future<ImageListState> applyAsync({ImageListState currentState, ImageListBloc bloc});
}

class ImageFetched extends ImageEvent {
 final ApiMethods _apiMethods = GetImageList();
 final int page;
 ImageFetched(this.page);

  @override
  Future<ImageListState> applyAsync({ImageListState currentState, ImageListBloc bloc}) async {
    int _page = 0;
    if(currentState is ImageLoaded){
      _page = currentState.page + 1;
    }
    try{
      List<Photo> imageListData = await _apiMethods.getResponseFromUrl(ApiKey.CLIENT_ID, page);
      return ImageLoaded(imageListData, page);
    } catch(error,stacktrace) {
      print("$error $stacktrace");
      return ImageError();
    }
  }
}
