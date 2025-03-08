part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    this.game,
    this.status = Status.init,
  });

  final GameEntity? game;
  final Status status;

  GameState copyWith({
    GameEntity? game,
    Status? status,
  }) {
    return GameState(
      game: game ?? this.game,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        game,
        status,
      ];
}
