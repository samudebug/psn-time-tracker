import 'package:dio/dio.dart';

class APIError implements Exception {
  const APIError(this.errorCode);
  final int errorCode;
}

class APIRepository {
  APIRepository() : dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000"));
  final Dio dio;
  Future<dynamic> performGet(String url, Map<String, dynamic> params) async {
    try {
      final response = await dio.get(url, queryParameters: params);
      print("response ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      
    }
  }
}