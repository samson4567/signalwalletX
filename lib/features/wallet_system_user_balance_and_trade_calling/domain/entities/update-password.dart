import 'package:equatable/equatable.dart';

class PasswordUpdateEntity extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  const PasswordUpdateEntity({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  @override
  List<Object> get props =>
      [currentPassword, newPassword, newPasswordConfirmation];
}
