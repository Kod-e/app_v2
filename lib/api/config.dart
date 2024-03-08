import 'package:dio/dio.dart';


Dio configureDio() {
  final options = BaseOptions(
    baseUrl: 'http://127.0.0.1:5015/',
    connectTimeout: Duration(seconds: 20),
    receiveTimeout: Duration(seconds: 20),
  );
  //添加options，并且返回
  final anotherDio = Dio(options);
  //添加拦截器
  anotherDio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // Do something before request is sent.
      // If you want to resolve the request with custom data,
      // you can resolve a `Response` using `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject with a `DioException` using `handler.reject(dioError)`.
      return handler.next(options);
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      // Do something with response data.
      // If you want to reject the request with a error message,
      // you can reject a `DioException` object using `handler.reject(dioError)`.
      return handler.next(response);
    },
    onError: (DioException error, ErrorInterceptorHandler handler) {
      // Do something with response error.
      // If you want to resolve the request with some custom data,
      // you can resolve a `Response` object using `handler.resolve(response)`.
      return handler.next(error);
    },
  ),
);
  return anotherDio;
}
final dio = configureDio(); // With default `Options`.