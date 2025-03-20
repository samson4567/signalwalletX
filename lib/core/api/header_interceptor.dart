import 'package:dio/dio.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor({
    required this.appPreferenceService,
    required this.dio,
  });

  final AppPreferenceService appPreferenceService;
  final Dio dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isAuthHeaderRequired = options.extra['isAuthHeaderRequired'] ?? false;
    if (isAuthHeaderRequired) {
      final tokenModel =
          appPreferenceService.getValue<String>(SecureKey.loginAuthTokenKey);
      if (tokenModel != null) {
        //final result = TokenModel.deserialize(tokenModel);
        options.headers['Authorization'] = 'Bearer ${tokenModel}';
      }
    }
    options.extra.clear();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
