import 'package:signalwavex/features/authentication/domain/entities/language_entity.dart';

class LanguagesModel extends LanguagesEntity {
  const LanguagesModel({
    required super.code,
    required super.name,
  });

  factory LanguagesModel.fromJson(Map<String, dynamic> json) {
    return LanguagesModel(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}
