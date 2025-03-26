import 'package:signalwavex/features/authentication/domain/entities/update-password.dart';

class PasswordUpdateModel extends PasswordUpdateEntity {
  const PasswordUpdateModel({
    required super.currentPassword,
    required super.newPassword,
    required super.newPasswordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "current_password": currentPassword,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation,
    };
  }
}
