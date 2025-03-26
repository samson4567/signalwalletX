import 'package:equatable/equatable.dart';

class DepositAddressEntity extends Equatable {
  final String? currency;
  final String? chain;
  final String? depositAddress;
  final String? qRCode;

  const DepositAddressEntity({
    required this.qRCode,
    required this.depositAddress,
    required this.currency,
    required this.chain,
  });

  @override
  List<Object?> get props => [
        qRCode,
        depositAddress,
        currency,
        chain,
      ];
}
