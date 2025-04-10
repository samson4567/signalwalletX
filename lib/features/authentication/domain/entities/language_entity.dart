import 'package:equatable/equatable.dart';

class LanguagesEntity extends Equatable {
  final String code;
  final String name;

  const LanguagesEntity({
    required this.code,
    required this.name,
  });

  @override
  List<Object?> get props => [code, name];
}
