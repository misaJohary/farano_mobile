import 'package:equatable/equatable.dart';
import 'package:farano/game/domain/entities/game_config_entity.dart';
import 'package:farano/game/domain/entities/game_entity.dart';
import 'package:farano/game/domain/entities/match_entity.dart';
import 'package:farano/game/domain/repositories/match_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/match_model.dart';
import '../../../domain/entities/player_entity.dart';

part 'match_event.dart';

part 'match_state.dart';

enum Status {
  init,
  loading,
  succeed,
  failed,
}

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final MatchRepository repo;

  MatchBloc(this.repo) : super(const MatchState()) {
    on<MatchCreated>(_onMatchCreated);
    on<MatchJoined>(_onMatchJoined);
    on<MatchUpdated>(_onMatchUpdated);
  }

  _onMatchCreated(event, emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await repo.createMatch(
      PlayerEntity.first(),
      GameConfigEntity.byDefault(),
    );
    if (result.isSuccess) {
      emit(
        state.copyWith(
          status: Status.succeed,
          match: result.getSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: Status.failed,
        ),
      );
    }
  }

  _onMatchJoined(event, emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await repo.joinMatch(PlayerEntity.second(), event.code);
    if (result.isSuccess) {
      emit(
        state.copyWith(
          status: Status.loading,
          currentGame: result.getSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: Status.failed,
        ),
      );
    }
  }

  _onMatchUpdated(event, emit) {
    final id = state.match?.id;
    event.match['id'] = id;
    emit(state.copyWith(match: MatchModel.fromJson(event.match)));
  }
}
