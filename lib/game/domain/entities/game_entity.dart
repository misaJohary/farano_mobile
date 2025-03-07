import 'package:equatable/equatable.dart';
import 'package:farano/game/domain/entities/player_entity.dart';

abstract class GameEntity extends Equatable {
  const GameEntity({
    this.id,
    this.currentWord = '',
    this.players = const [],
    this.currentPlayerId = '',
    this.status = GameStatus.playing,
  });

  final String? id;
  final String currentWord;
  final List<PlayerEntity> players;
  final String currentPlayerId;
  final GameStatus status;

  @override
  List<Object?> get props => [
        id,
        currentWord,
        players,
        currentPlayerId,
        status,
      ];
}

enum GameStatus {
  playing,
  paused,
  completed,
}