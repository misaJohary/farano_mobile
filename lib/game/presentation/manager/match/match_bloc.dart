import 'package:equatable/equatable.dart';
import 'package:farano/game/domain/entities/game_config_entity.dart';
import 'package:farano/game/domain/entities/game_entity.dart';
import 'package:farano/game/domain/entities/match_entity.dart';
import 'package:farano/game/domain/repositories/game_repository.dart';
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
  final GameRepository repo;

  MatchBloc(this.repo) : super(const MatchState()) {
    on<GameCreated>(_onGameCreated);
    on<GameJoined>(_onGameJoined);
    on<GameMatchUpdated>(_onGameMatchUpdated);
  }

  _onGameCreated(event, emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await repo.createGame(
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

  _onGameJoined(event, emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await repo.joinGame(PlayerEntity.second(), event.code);
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

  _onGameMatchUpdated(event, emit) {
    final id = state.match?.id;
    event.match['id'] = id;
    emit(state.copyWith(match: MatchModel.fromJson(event.match)));
  }
}
