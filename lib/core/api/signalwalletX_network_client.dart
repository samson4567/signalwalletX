import 'package:dio/dio.dart';
import 'package:signalwavex/core/api/api_client.dart';
import 'package:signalwavex/core/api/base_response.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';

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
    bool returnRawData = false,
  }) async {
    final requestOptions = options ?? Options();

    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.get(
      endpoint: endpoint,
      options: requestOptions,
      params: params,
    );
    BaseResponse baseResponse = BaseResponse.fromJson({});
    if (returnRawData) {
      baseResponse.data = response;
    } else {
      baseResponse = BaseResponse.fromJson(response);
    }

    return baseResponse;
  }

  @override
  Future<BaseResponse> post({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
    bool returnRawData = false,
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
    print("fresh>>${response}");
    if (endpoint == EndpointConstant.login) {
      (response as Map<String, dynamic>)["data"] = {
        "token": (response as Map).remove("token"),
        "user": (response as Map).remove("user")
      };
    }
    BaseResponse baseResponse = BaseResponse.fromJson(response);
    if (returnRawData) {
      baseResponse.data = response;
    }

    return baseResponse;
  }

  @override
  Future<BaseResponse> put({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
    bool returnRawData = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.put(
        endpoint: endpoint,
        data: data,
        options: requestOptions,
        params: params);
    BaseResponse baseResponse = BaseResponse.fromJson(response);
    if (returnRawData) {
      baseResponse.data = response;
    }

    return baseResponse;
  }

  @override
  Future<BaseResponse> patch({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
    bool returnRawData = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.patch(
        endpoint: endpoint,
        data: data,
        options: requestOptions,
        params: params);
    BaseResponse baseResponse = BaseResponse.fromJson(response);
    if (returnRawData) {
      baseResponse.data = response;
    }

    return baseResponse;
  }

  @override
  Future<BaseResponse> delete({
    required String endpoint,
    data,
    Options? options,
    Map<String, dynamic>? params,
    bool isAuthHeaderRequired = false,
    bool returnRawData = false,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?['isAuthHeaderRequired'] = isAuthHeaderRequired;
    final response = await super.delete(
        endpoint: endpoint,
        data: data,
        options: requestOptions,
        params: params);
    BaseResponse baseResponse = BaseResponse.fromJson(response);
    if (returnRawData) {
      baseResponse.data = response;
    }

    return baseResponse;
  }
}
