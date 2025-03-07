import 'package:equatable/equatable.dart';
import 'package:farano/game/domain/entities/game_config_entity.dart';
import 'package:farano/game/domain/entities/game_entity.dart';
import 'package:farano/game/domain/entities/match_entity.dart';
import 'package:farano/game/domain/repositories/game_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/player_entity.dart';

part 'game_event.dart';

part 'game_state.dart';

enum GameStatus {
  init,
  loading,
  waiting,
  started,
  canceled,
  failed,
}

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository repo;

  GameBloc(this.repo) : super(const GameState()) {
    on<GameCreated>(_onGameCreated);
    on<GameJoined>(_onGameJoined);
  }

  _onGameCreated(event, emit) async {
    emit(state.copyWith(gameStatus: GameStatus.loading));
    final result = await repo.createGame(
      PlayerEntity.first(),
      GameConfigEntity.byDefault(),
    );
    if (result.isSuccess) {
      emit(
        state.copyWith(
          gameStatus: GameStatus.waiting,
          match: result.getSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          gameStatus: GameStatus.failed,
        ),
      );
    }
  }

  _onGameJoined(event, emit) async {
    emit(state.copyWith(gameStatus: GameStatus.loading));
    final result = await repo.joinGame(PlayerEntity.second(), event.code);
    if (result.isSuccess) {
      emit(
        state.copyWith(
          gameStatus: GameStatus.waiting,
          currentGame: result.getSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          gameStatus: GameStatus.failed,
        ),
      );
    }
  }
}
