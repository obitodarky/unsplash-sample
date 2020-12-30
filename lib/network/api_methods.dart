import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/i_client.dart';
import 'package:unsplash_sample/network/repository.dart';
import 'package:unsplash_sample/utils/urls.dart';

abstract class ApiMethods {
  Future<List<Photo>> getResponseFromUrl(String clientID, int page);
  Future<List<Photo>> getSearchedImages(String clientID, int page, String query);
}

class GetImageList extends ApiMethods{
  IClient _iClient;

  GetImageList(){
    _iClient = PhotoRestApi();
  }

  @override
  Future<List<Photo>> getResponseFromUrl(String clientID, int page) async {
    var result = await _iClient.getAsync("${ApiUrls.GET_IMAGE}?client_id=$clientID&page=$page");
    if(result.networkServiceResponse.success){
      List<Photo> res = List<Photo>.from(result.mappedResult.map<Photo>((e) => Photo.fromJson(e))).toList();
      return res;
    }
    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<List<Photo>> getSearchedImages(String clientID, int page, String query) async {
    var result = await _iClient.getAsync("${ApiUrls.GET_IMAGE}?client_id=$clientID&query=$query&page=$page");
    if(result.networkServiceResponse.success){
      List<Photo> res = List.from(result.mappedResult.map((e) => Photo.fromJson(e))).toList();
      return res;
    }
    throw Exception(result.networkServiceResponse.message);
  }

}