import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor{
  final logger = Logger(
    printer: PrettyPrinter(
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    logger.i("${options.method} REQUEST: ${options.baseUrl + options.path}");
    logger.i("Request Headers: ${options.headers}");
    if (options.method == "GET") {
      logger.i("QueryParams: ${options.queryParameters}");
    } else {
      logger.i("Request Body: ${options.data}");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler){
    logger.d('Response Data: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler){
    logger.e("Error: ${err.response?.data}");
    logger.e("Status Code: ${err.response?.statusCode}");
    return super.onError(err, handler);
  }
}