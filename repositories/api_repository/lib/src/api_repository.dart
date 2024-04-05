import 'package:dio/dio.dart';

class APIError implements Exception {
  const APIError(this.errorCode);
  final int errorCode;
}

class APIRepository {
  APIRepository() : dio = Dio(BaseOptions(baseUrl: "https://backend-u465rfcqhq-uc.a.run.app"));
  final Dio dio;
  Future<dynamic> performGet({String? cookie, required String url, required Map<String, dynamic> headers, required Map<String, dynamic> params}) async {
    try {
      final response = await dio.get(url, queryParameters: params, options: Options(headers: headers));
      return response.data;
    } catch (e) {
      print(e);
      
    }
  }
}