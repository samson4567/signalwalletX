import 'package:dio/dio.dart';
import 'package:signalwavex/core/api/api_client.dart';
import 'package:signalwavex/core/api/base_response.dart';

class SignalWalletNetworkClient extends ApiClient {
  SignalWalletNetworkClient({
    required super.dio,
    required super.appPreferenceService,
  });

  @override
  Future<BaseResponse> get({
    required String endpoint,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.get(
      endpoint: endpoint,
      options: requestOptions,
      params: params,
    );
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> post({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.post(
      endpoint: endpoint,
      data: data,
      options: requestOptions,
      params: params,
    );

    (response as Map<String, dynamic>)["data"] = {
      "token": (response as Map).remove("token"),
      "user": (response as Map).remove("user")
    };

    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> put({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.put(
        endpoint: endpoint,
        data: data,
        options: requestOptions,
        params: params);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> patch({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.patch(
        endpoint: endpoint,
        data: data,
        options: requestOptions,
        params: params);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> delete({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.delete(
        endpoint: endpoint,
        data: data,
        options: requestOptions,
        params: params);
    return BaseResponse.fromJson(response);
  }
}
