import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../util/app_component.dart';

//日志拦截器
class LoggingInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    appPrint('-------------------------------------------------');
    appPrint(
      "- 请求url：${options.baseUrl}${options.path} 类型 ${options.method} -",
    );
    appPrint('- 请求头: ${options.headers.toString()} -');

    if (options.data != null) {
      Logger().i(options.data);
    }
    appPrint('- 请求参数queryParameters: ${options.queryParameters.toString()} -');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response == null) {
      showToast("网络异常");
    }
    Logger().d(err.response);
    print('err ${err.error}  ${err.type}');
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    appPrint(
      '--- 返回的${response.requestOptions.baseUrl}${response.requestOptions.path} ----',
    );
    //if(![Api.adjustable].contains(response.requestOptions.path))
    // Logger().d(response.data);
    if (!response.requestOptions.path.contains("/api/stock/data/real-time")
    // && !response.requestOptions.path.contains("/api/stock/data/history")
    ) {
      Logger().d(response.data);
    }
    super.onResponse(response, handler);
  }
}
