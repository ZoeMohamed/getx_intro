import 'package:dio/dio.dart';
import 'package:getx_intro/consts.dart';

class HttpService {
  final Dio _dio = Dio();

  HttpService() {
    _configureDio();
  }

  void _configureDio() {
    // BaseOptions is a class provided by Dio that allows you to configure various options for HTTP requests.
    //In this example, it is being used to set the base URL and default query parameters.
    _dio.options = BaseOptions(
        baseUrl: "https://api.cryptorank.io/v1/",
        queryParameters: {"api_key": CRYPTO_API});
  }

  Future<dynamic> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
