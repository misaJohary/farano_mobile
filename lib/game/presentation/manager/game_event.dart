part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameCreated extends GameEvent {
  const GameCreated();

  @override
  List<Object?> get props => [];
}

class GameJoined extends GameEvent{
  const GameJoined(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}
