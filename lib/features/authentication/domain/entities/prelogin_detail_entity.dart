import 'package:equatable/equatable.dart';

class PreloginDetailEntity extends Equatable {
  final bool? toBeLoggedIn;
  final String? autoLoginExpirationDate;
  final String? authToken;

  const PreloginDetailEntity({
    required this.authToken,
    required this.autoLoginExpirationDate,
    required this.toBeLoggedIn,
  });

  @override
  List<Object> get props => [];
}
