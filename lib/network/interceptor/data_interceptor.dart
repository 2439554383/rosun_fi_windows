import 'package:dio/dio.dart';

//数据拦截器
class DataInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final data = response.data;
    // 🔒 先判断返回类型是不是 Map（即 JSON）
    if (data is Map<String, dynamic>) {
      var code = data['code'];
      switch (code) {
        case 401:
          // UserData().logOut();
          break;
        default:
          break;
      }
    } else {
      // ⚠️ 如果不是 JSON（例如纯字符串）
      print("⚠️ 非JSON响应: ${response.data}");
    }

    super.onResponse(response, handler);
  }
}
