import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:unsplash_sample/key.dart';
import 'package:unsplash_sample/network/i_client.dart';
import 'package:unsplash_sample/network/service_response.dart';



class PhotoReceiveRepository extends IClient{

  @override
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(int page) async {
    Response response = await Dio().get("https://api.unsplash.com/photos/?client_id=${ApiKey.CLIENT_ID}&page=$page");
    return await processResponse<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> processResponse<T>(
      Response response) async {
    try {
      if (!((response.statusCode < HttpStatus.ok) ||
          (response.statusCode >= HttpStatus.multipleChoices) ||
          (response.data == null))) { //response.data instead of response.body
        //var resultClass = await compute(jsonParserIsolate, response.data);

        return MappedNetworkServiceResponse<T>(
            mappedResult: resultClass,
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

  static Map<String, dynamic> jsonParserIsolate(String res) {
    return jsonDecode(res);
  }

}