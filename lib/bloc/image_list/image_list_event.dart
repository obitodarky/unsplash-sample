import 'package:equatable/equatable.dart';
import 'package:unsplash_sample/bloc/infinite_list/image_list_state.dart';
import 'package:unsplash_sample/bloc/infinite_list/image_list_bloc.dart';
import 'package:unsplash_sample/key.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/api_methods.dart';

abstract class ImageEvent{
  Future<ImageListState> applyAsync({ImageListState currentState, ImageListBloc bloc, int page});
}

class ImageFetched extends ImageEvent {
 final ApiMethods _apiMethods = GetImageList();

  @override
  Future<ImageListState> applyAsync({ImageListState currentState, ImageListBloc bloc, int page}) async {
    try{
      List<Photo> imageListData = await _apiMethods.getResponseFromUrl(ApiKey.CLIENT_ID, page);
      return ImageLoaded(imageListData, page);
    } catch(error,stacktrace) {
      print(error);
      return ImageError();
    }
  }
}
