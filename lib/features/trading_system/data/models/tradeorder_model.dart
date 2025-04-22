import 'package:signalwavex/features/trading_system/domain/entities/tradeorder_entity.dart';

class TraderOrderFollowedModel extends TraderOrderFollowedEntity {
  const TraderOrderFollowedModel({required super.tid});

  factory TraderOrderFollowedModel.fromJson(Map<String, dynamic> json) {
    return TraderOrderFollowedModel(
      tid: json['tid'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
    };
  }
}
