import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class MyInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     super.onRequest(options, handler);
//   }
//    @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     super.onResponse(response, handler);
//   }
// }

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(Dio());
});

class ApiClient {
  final Dio _dio;
  ApiClient(Dio dio) : _dio = dio {
    _dio.options.baseUrl = "https://fakestoreapi.com/";
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    var res = await _dio.get(path, queryParameters: queryParameters);
    if (res.statusCode == null) return null;

    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      return res.data;
    }
  }

  Future post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    var res =
        await _dio.post(path, data: data, queryParameters: queryParameters);
    if (res.statusCode == null) return null;

    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      return res.data;
    }
  }

  Future delete(String path, {Object? data}) async {
    var res = await _dio.delete(path, data: data);
    if (res.statusCode == null) return null;

    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      return res.data;
    }
  }
}

// API Methods
// 1. GET
// 2. POST
// 3. PUT
// 4. PATCH
// 5. DELETE

// Response:
// StatusCode, Response Header, Response Body

// Status Code
// 100 - 199


// Interceptors
// -> on request | on response | on error
// -> Intercept the API calls 