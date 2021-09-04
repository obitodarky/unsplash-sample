import 'dart:io';
import 'package:dio/dio.dart';
import 'package:unsplash_sample/model/service_response.dart';
import 'package:unsplash_sample/network/i_client.dart';


class RestApi extends IClient{

  @override
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String url, Map<String, dynamic> queryParams) async {
    Response response = await Dio().get(url, queryParameters: queryParams);

    return await processResponse(response);
  }

  Future<MappedNetworkServiceResponse<T>> processResponse<T>(
      Response response) async {
    try {
      if (response.data != null && response.statusCode == HttpStatus.ok) { //response.data instead of response.body


        return MappedNetworkServiceResponse<T>(
            mappedResult: response.data,
            networkServiceResponse: NetworkServiceResponse<T>(success: true));
      } else {
        var errorResponse = response.data;
        return MappedNetworkServiceResponse<T>(
            networkServiceResponse: NetworkServiceResponse<T>(
                success: false,
                message:
                "(${response.statusCode}) ${errorResponse.toString()}"));
      }
    } on SocketException catch (_) {
      return MappedNetworkServiceResponse<T>(
          networkServiceResponse: NetworkServiceResponse<T>(
              success: false,
              message:
              "(${response.statusCode}) Can't reach the servers, \n Please check your internet connection."));
    }
  }

}