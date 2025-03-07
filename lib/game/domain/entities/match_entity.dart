import 'package:equatable/equatable.dart';

class MatchEntity extends Equatable {
  const MatchEntity(
      {required this.id,
      required this.code,
      this.hostName,
      this.config,
      this.status = MatchStatus.waiting,
      this.currentGameId});

  final String id;
  final String code;
  final String? hostName;
  final Map<String, dynamic>? config;
  final MatchStatus status;
  final String? currentGameId;

  @override
  List<Object?> get props => [
        id,
        code,
        hostName,
        config,
        status,
        currentGameId,
      ];
}

enum MatchStatus {
  waiting,
  player2Entered,
  gameCreated,
  completed,
  abandoned,
}
