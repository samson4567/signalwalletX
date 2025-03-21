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

    //  so ther is a special case here needed to be attended to by the backender,
    // the formmat being inconsistent is making it not to se the  token
    /* expected body format =  {
      "message": "dummy message",
      "data": {
        "key": "value",
      },
      "success":true
    };
    
    recieved body format={
          "message": "Login successful",
          "token": "87|aFukpw8qFUBd0isoYxrc5WUrHD3gDdKDziNjbdSv938f03d5",
          "user": {
              "id": 33,
              "name": null,
              "email": "Kederky658@gmail.com",
              "role": "trader"
         }
     }
    */

    // adjustment to be made
    (response as Map<String, dynamic>)["data"] = {
      "token": (response as Map).remove("token"),
      "user": (response as Map).remove("user")
    };
    print("sbbshdbsdjbxbckjxbckb--1${response.runtimeType}");
    print("sbbshdbsdjbxbckjxbckb--2${response}");
    // print("sbbshdbsdjbxbckjxbckb--2${response}");

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
