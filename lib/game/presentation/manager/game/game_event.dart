part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameUpdated extends GameEvent {
  final GameEntity? game;
  final String? gameId;

  const GameUpdated(
    this.game,
    this.gameId,
  );

  @override
  List<Object?> get props => [
        game,
        gameId,
      ];
}
