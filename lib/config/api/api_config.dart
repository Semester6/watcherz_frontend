import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiConfig {
  Dio initDio() {
    Dio _dio = Dio();
    _dio.options.baseUrl = 'https://favomedic.com/api';
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
    _dio.options.contentType = "application/json";
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _dio.interceptors.add(ApiInterceptors());

    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("Bearer");
    // if (err.response!.statusCode == 401) {
    //   if (token != "" && token != null) {
    //     getIt<AppRouter>().replace(
    //         LogOutPageRoute(message: err.response!.statusCode.toString()));
    //   }
    // }
    return super.onError(err, handler);
  }
}
