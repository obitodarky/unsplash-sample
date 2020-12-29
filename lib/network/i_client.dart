import 'index.dart';

abstract class IClient {
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String url);
}