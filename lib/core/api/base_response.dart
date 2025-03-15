
class BaseResponse {
  String success;
  String message;
  dynamic data;

  BaseResponse({
    required this.success, required this.message, required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    String status = json['success'] is bool ? (json['success'] ? 'true' : 'false')
        : json['success'].toString();
    return BaseResponse(
      success: status,
      message: json['message'],
      data: json['data'],
    );
  }
}