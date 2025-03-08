import 'package:equatable/equatable.dart';
import 'package:farano/game/domain/entities/player_entity.dart';

class GameEntity extends Equatable {
  const GameEntity({
    this.id,
    this.currentWord = '',
    this.players = const [],
    this.currentPlayerId = '',
    this.status = GameStatus.playing,
    this.currentGameId,
  });

  final String? id;
  final String currentWord;
  final List<PlayerEntity> players;
  final String? currentPlayerId;
  final GameStatus status;
  final String? currentGameId;

  @override
  List<Object?> get props => [
        id,
        currentWord,
        players,
        currentPlayerId,
        status,
    currentGameId,
      ];

  GameEntity copyWith({
    String? id,
    String? currentWord,
    List<PlayerEntity>? players,
    String? currentPlayerId,
    GameStatus? status,
    String? currentGameId,
  }) {
    return GameEntity(
      id: id ?? this.id,
      currentWord: currentWord ?? this.currentWord,
      players: players ?? this.players,
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      status: status ?? this.status,
      currentGameId: currentGameId ?? this.currentGameId,
    );
  }

  // CustomWidget merge(CustomWidget other) {
  //   return CustomWidget(
  //     width: other.width ?? this.width,
  //     height: other.height ?? this.height,
  //     color: other.color ?? this.color,
  //   );
  // }
}

enum GameStatus {
  active,
  playing,
  paused,
  completed,
}