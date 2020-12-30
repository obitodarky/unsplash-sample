import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:unsplash_sample/network/i_client.dart';
import 'package:unsplash_sample/network/service_response.dart';



class PhotoRestApi extends IClient{

  @override
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String url, Map<String, dynamic> queryParams) async {
    Response response = await Dio().get(url, queryParameters: queryParams);

    return await processResponse<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> processResponse<T>(
      Response response) async {
    try {
      if (!((response.statusCode < HttpStatus.ok) ||
          (response.statusCode >= HttpStatus.multipleChoices) ||
          (response.data == null))) { //response.data instead of response.body


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

  static Future<Map<String, dynamic>> jsonParserIsolate(dynamic res) async {
    print(res);
    return jsonDecode(res);
  }

}