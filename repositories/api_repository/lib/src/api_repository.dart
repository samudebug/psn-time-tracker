import 'package:dio/dio.dart';

class APIError implements Exception {
  const APIError(this.errorCode);
  final int errorCode;
}

class APIRepository {
  APIRepository() : dio = Dio(BaseOptions(baseUrl: "https://psn-time-tracker-api.onrender.com"));
  final Dio dio;
  Future<dynamic> performGet(String url, Map<String, dynamic> params, {String? cookie}) async {
    try {
      final response = await dio.get(url, queryParameters: params, options: Options(headers: {'Cookie': cookie ?? ""}));
      return response.data;
    } catch (e) {
      print(e);
      
    }
  }
}