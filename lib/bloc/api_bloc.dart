import 'image_list_state.dart';
import 'package:unsplash_sample/key.dart';
import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/api_methods.dart';
import 'package:unsplash_sample/utils/urls.dart';

class ApiBloc {
  final ApiMethods _apiMethods = GetImageList();

  Future<ImageListState> getImages(int page) async {
    try{
      List<Photo> tempImageListData = await _apiMethods.getResponseFromUrl(
          ApiUrls.GET_IMAGE, {"client_id": ApiKey.CLIENT_ID, "page": page});
      return ImageLoaded(tempImageListData, page);
    } catch(error,stacktrace) {
      print("$error $stacktrace");
      return ImageError();
    }
  }
}
