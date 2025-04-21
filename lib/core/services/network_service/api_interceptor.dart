import 'package:demoproject/core/constants/shared_pref_keys.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/core/services/shared_pref_service.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({this.dioInstance});

  final Dio? dioInstance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? accessToken = getIt<SharedPrefsServices>().getString(
      key: SharedPrefKeys.tokenKey,
    );

    if (accessToken != null) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');
    }
    return super.onRequest(options, handler);
  }
}
