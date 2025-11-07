import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration initialDelay;

  RetryInterceptor({
    this.maxRetries = 2,
    this.initialDelay = const Duration(milliseconds: 500),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final requestOptions = err.requestOptions;
      final retryCount = requestOptions.extra['retryCount'] ?? 0;

      if (retryCount < maxRetries) {
        requestOptions.extra['retryCount'] = retryCount + 1;

        final delayMillis =
            (initialDelay.inMilliseconds * (retryCount + 1)).toInt();
        await Future.delayed(Duration(milliseconds: delayMillis));

        try {
          final dio = Dio();
          final response = await dio.fetch(requestOptions);
          return handler.resolve(response);
        } catch (e) {
          if (e is DioException) {
            return super.onError(e, handler);
          }
          return super.onError(err, handler);
        }
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.unknown;
  }
}
