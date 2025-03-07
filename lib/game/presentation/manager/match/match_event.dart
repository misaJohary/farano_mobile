part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();
}

class MatchCreated extends MatchEvent {
  const MatchCreated();

  @override
  List<Object?> get props => [];
}

class MatchJoined extends MatchEvent{
  const MatchJoined(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

class MatchUpdated extends MatchEvent{
  const MatchUpdated(this.match);

  final Map<String, dynamic> match;

  @override
  List<Object?> get props => [match];
}
