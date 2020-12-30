import 'package:unsplash_sample/model/photo_model.dart';
import 'package:unsplash_sample/network/i_client.dart';
import 'package:unsplash_sample/network/repository.dart';
import 'package:unsplash_sample/utils/urls.dart';

abstract class ApiMethods {
  Future<List<Photo>> getResponseFromUrl(String url, Map<String, dynamic> queryParams);
  Future<List<Photo>> getSearchedImages(String url, Map<String, dynamic> queryParam);
}

class GetImageList extends ApiMethods{
  IClient _iClient;

  GetImageList(){
    _iClient = PhotoRestApi();
  }

  @override
  Future<List<Photo>> getResponseFromUrl(String url, Map<String, dynamic> queryParam) async {
    var result = await _iClient.getAsync(url, queryParam);
    if(result.networkServiceResponse.success){
      print(result.mappedResult);
      List<Photo> res = List<Photo>.from(result.mappedResult.map<Photo>((e) => Photo.fromJson(e))).toList();
      return res;
    }
    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<List<Photo>> getSearchedImages(String url, Map<String, dynamic> queryParam) async {
    var result = await _iClient.getAsync(url, queryParam);
    if(result.networkServiceResponse.success){
      List<Photo> res = List<Photo>.from(result.mappedResult['results'].map((e) => Photo.fromJson(e))).toList();
      return res;
    }
    throw Exception(result.networkServiceResponse.message);
  }

}