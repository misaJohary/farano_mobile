part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    this.gameStatus = GameStatus.init,
    this.match,
    this.currentGame,
  });

  final GameStatus gameStatus;
  final MatchEntity? match;
  final GameEntity? currentGame;

  GameState copyWith({
    GameStatus? gameStatus,
    MatchEntity? match,
    GameEntity? currentGame,
  }) {
    return GameState(
      gameStatus: gameStatus ?? this.gameStatus,
      match: match ?? this.match,
      currentGame: currentGame ?? this.currentGame,
    );
  }

  @override
  List<Object?> get props => [
        gameStatus,
        match,
        currentGame,
      ];
}
