import 'package:dio/dio.dart';
class NetworkManager {
  final Dio dio;

  const NetworkManager._(this.dio);

  factory NetworkManager(){
    final dio = Dio();

    return NetworkManager._(dio);
  }

  Future<Response<T>> request<T>(
    RequestMethod method,
    String url,{
      data,
      Map<String,dynamic>? headers,
      Map<String,dynamic>? queryparameters,
    }
  ){
    return dio.request(
      url,
      data: data,
      queryParameters: queryparameters,
      options: Options(
        method: method.value,
        headers: headers,
      )
    );
  }

}


String getEnumValue(e) => e.toString().split('.').last;

enum RequestMethod {
  get,
  head,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch,
}

extension RequestMethodX on RequestMethod {
  String get value => getEnumValue(this).toUpperCase();
}
