import 'package:signalwavex/features/authentication/domain/entities/prelogin_detail_entity.dart';

// LoginEntity

class PreloginDetailModel extends PreloginDetailEntity {
  const PreloginDetailModel({
    super.authToken,
    super.autoLoginExpirationDate,
    super.toBeLoggedIn,
  });

  factory PreloginDetailModel.fromJson(Map<String, dynamic> json) {
    return PreloginDetailModel(
      authToken: json['authToken'],
      autoLoginExpirationDate: json['autoLoginExpirationDate'],
      toBeLoggedIn: json['toBeLoggedIn'],
    );
  }

  factory PreloginDetailModel.fromEntity(
      PreloginDetailEntity preloginDetailEntity) {
    return PreloginDetailModel(
      authToken: preloginDetailEntity.authToken,
      autoLoginExpirationDate: preloginDetailEntity.autoLoginExpirationDate,
      toBeLoggedIn: preloginDetailEntity.toBeLoggedIn,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authToken': authToken,
      'autoLoginExpirationDate': autoLoginExpirationDate,
      'toBeLoggedIn': toBeLoggedIn,
    };
  }
}
