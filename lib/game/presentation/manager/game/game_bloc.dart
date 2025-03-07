import 'package:equatable/equatable.dart';
import 'package:farano/game/domain/repositories/game_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/game_entity.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepo;

  GameBloc(this.gameRepo) : super(const GameState()) {
    on<GameUpdated>(_onGameUpdated);
  }

  _onGameUpdated(event, emit) async {
    if (event.gameId != null) {
      emit(state.copyWith(status: Status.loading));
      final result = await gameRepo.joinGame(event.gameId!);
      if (result.isSuccess) {
        emit(
          state.copyWith(
            status: Status.succeed,
            game: result.getSuccess,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: Status.failed,
          ),
        );
      }
    } else if (event.game != null) {
      emit(state.copyWith(game: event.game));
    }
  }
}