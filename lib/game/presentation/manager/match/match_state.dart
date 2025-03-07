part of 'match_bloc.dart';

class MatchState extends Equatable {
  const MatchState({
    this.status = Status.init,
    this.match,
    this.currentGame,
  });

  final Status status;
  final MatchEntity? match;
  final GameEntity? currentGame;

  MatchState copyWith({
    Status? status,
    MatchEntity? match,
    GameEntity? currentGame,
  }) {
    return MatchState(
      status: status ?? this.status,
      match: match ?? this.match,
      currentGame: currentGame ?? this.currentGame,
    );
  }

  @override
  List<Object?> get props => [
        status,
        match,
        currentGame,
      ];
}
