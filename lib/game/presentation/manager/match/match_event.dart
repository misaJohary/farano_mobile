part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();
}

class GameCreated extends MatchEvent {
  const GameCreated();

  @override
  List<Object?> get props => [];
}

class GameJoined extends MatchEvent{
  const GameJoined(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

class GameMatchUpdated extends MatchEvent{
  const GameMatchUpdated(this.match);

  final Map<String, dynamic> match;

  @override
  List<Object?> get props => [match];
}
