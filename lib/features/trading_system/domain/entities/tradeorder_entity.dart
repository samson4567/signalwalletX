import 'package:equatable/equatable.dart';

class TraderOrderFollowedEntity extends Equatable {
  final String tid;

  const TraderOrderFollowedEntity({required this.tid});

  @override
  List<Object?> get props => [tid];
}
