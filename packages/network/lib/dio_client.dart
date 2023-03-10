import "package:config/config.dart";
import "package:dio/dio.dart";

import "../utilities/constants.dart";
import "dio_interceptor.dart";

class DioClient {
  static DioClient? _dioClient;
  static late Dio _dio;

  factory DioClient() {
    _dioClient ??= DioClient._internal();
    return _dioClient!;
  }

  DioClient._internal() {
    var cfg = Config();
    _dio = Dio(
      BaseOptions(
        baseUrl: cfg.get(BASE_URL),
        connectTimeout:
            Duration(milliseconds: int.parse(cfg.get(CONNECT_TIMEOUT))),
        receiveTimeout:
            Duration(milliseconds: int.parse(cfg.get(RECEIVE_TIMEOUT))),
        responseType: ResponseType.json,
      ),
    );
    _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio => _dio;

  void dispose() {
    _dio.close();
  }
}
