import 'package:equatable/equatable.dart';
import 'package:farano/game/domain/repositories/game_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/status.dart';
import '../../../../core/utils/log.dart';
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
      Log.info('Joining game ${event.gameId}');
      emit(state.copyWith(status: Status.loading));
      final result = await gameRepo.joinGame(event.gameId!);
      if (result.isSuccess) {
        Log.info('join success');
        final game = result.getSuccess?.copyWith(id: event.gameId);
        emit(
          state.copyWith(
            status: Status.succeed,
            game: game,
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
      emit(
        state.copyWith(
          game: event.game.copyWith(id: state.game?.id),
        ),
      );
    }
  }
}
