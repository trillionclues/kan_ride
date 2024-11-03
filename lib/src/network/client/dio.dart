import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import '../interceptors/logging_interceptors.dart';
import '../../config/app_client_config_provider.dart';
import '../../storage/shared_preferences.dart';
import '../../constants/strings.dart';
import '../remote_response.dart';

enum RequestType { get, post, put, patch, delete, download }

final Map<String, String> header = {
  "Content-Type": "application/json",
  'Accept': 'application/json',
  // ...add additional default header options
};

class Api {
  final dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    final Dio dio = Dio(BaseOptions(
      baseUrl: appClientInfo.baseUrl,
      receiveTimeout: const Duration(milliseconds: 15000),
      connectTimeout: const Duration(milliseconds: 15000),
      sendTimeout: const Duration(milliseconds: 15000),
    ));

    var cookieJar = CookieJar();

    dio.interceptors.addAll([
      LoggingInterceptor(),
      CookieManager(cookieJar),
      QueuedInterceptorsWrapper(onRequest: (options, handler) async {
        final pref = await SharedPreferences.getInstance();
        String? token = CacheData.getToken(pref: pref);
        if (token != null) {
          // set token to request headers
          options.headers["Token"] = token;
        }
        return handler.next(options);
      })
    ]);
    return dio;
  }

  Future<RemoteResponse> apiCall({
    required RequestType requestType,
    required String url,
    dynamic savePath,
    Options? options,
    Dio? newDio,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Response? result;

    try {
      switch (requestType) {
        case RequestType.get:
          {
            result = newDio == null
                ? await dio.get(
                    url,
                    options: options ?? Options(headers: header),
                    queryParameters: queryParameters,
                    cancelToken: cancelToken,
                    onReceiveProgress: onReceiveProgress,
                  )
                : await newDio.get(
                    url,
                    queryParameters: queryParameters,
                    options: options ?? Options(headers: header),
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  );
            break;
          }
        case RequestType.post:
          {
            result = newDio == null
                ? await dio.post(
                    url,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onSendProgress: onSendProgress,
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  )
                : await newDio.post(
                    url,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onSendProgress: onSendProgress,
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  );
            break;
          }
        case RequestType.delete:
          {
            result = newDio == null
                ? await dio.delete(
                    url,
                    queryParameters: queryParameters,
                    data: body,
                    options: options ?? Options(headers: header),
                    cancelToken: cancelToken,
                  )
                : await newDio.delete(
                    url,
                    queryParameters: queryParameters,
                    data: body,
                    options: options ?? Options(headers: header),
                    cancelToken: cancelToken,
                  );
            break;
          }
        case RequestType.put:
          {
            result = newDio == null
                ? await dio.put(
                    url,
                    queryParameters: queryParameters,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onSendProgress: onSendProgress,
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  )
                : await newDio.put(
                    url,
                    queryParameters: queryParameters,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onSendProgress: onSendProgress,
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  );
            break;
          }
        case RequestType.patch:
          {
            result = newDio == null
                ? await dio.patch(
                    url,
                    queryParameters: queryParameters,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onSendProgress: onSendProgress,
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  )
                : await newDio.patch(
                    url,
                    queryParameters: queryParameters,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onSendProgress: onSendProgress,
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  );
            break;
          }
        case RequestType.download:
          {
            result = newDio == null
                ? await dio.download(
                    url,
                    savePath,
                    queryParameters: queryParameters,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  )
                : await newDio.download(
                    url,
                    savePath,
                    queryParameters: queryParameters,
                    data: jsonEncode(body),
                    options: options ?? Options(headers: header),
                    onReceiveProgress: onReceiveProgress,
                    cancelToken: cancelToken,
                  );
            break;
          }
      }
      final status = result.data['status'];
      if (status == null) {
        return RemoteResponse.success(result.data);
      }
      if (status == Strings.success) {
        return RemoteResponse.success(result.data["data"]);
      } else {
        return RemoteResponse.error(result.data["message"]);
      }
    } on DioException catch (error) {
      return _handleDioError(error);
    } catch (error) {
      return RemoteResponse.somethingWentWrong();
    }
  }

  RemoteResponse _handleDioError(DioException error) {
    dynamic errorMsg;
    final errRes = error.response?.data;

    if (errRes != null && errRes is Map) {
      errorMsg = errRes['message'] ?? "An unexpected error occurred.";
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return RemoteResponse.internetConnectionError();
    } else {
      errorMsg = errRes ?? error.message;
    }
    return RemoteResponse.error(errorMsg);
  }
}
