import 'package:farano/game/data/models/game_model.dart';
import 'package:farano/game/domain/entities/game_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/game_service.dart';
import '../../../core/utils/failure.dart';
import '../../../core/utils/log.dart';
import '../../../core/utils/multi_result.dart';
import '../../domain/entities/game_config_entity.dart';
import '../../domain/entities/match_entity.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/repositories/match_repository.dart';
import '../models/match_model.dart';


@LazySingleton(as: MatchRepository)
class MatchRepositoryImpl implements MatchRepository {
  final GameService _gameService;

  MatchRepositoryImpl(this._gameService);

  @override
  Future<MultipleResult<Failure, MatchEntity>> createMatch(
    PlayerEntity player,
    GameConfigEntity config,
  ) async {
    try {
      final match = await _gameService.createNewMatch(
        player.id,
        player.username,
        {
          'timePerTurn': config.timePerTurn,
          'maxRematchCount': config.maxRematchCount
        },
      );

      return ResultSuccess(MatchModel.fromJson(match));
    } catch (_) {
      return ResultError(const ServerFailure('Failed to create game'));
    }
  }

  @override
  Future<MultipleResult<Failure, GameEntity>> joinMatch(
    PlayerEntity player,
    String code,
  ) async {
    try {
      final game = await _gameService.joinMatchWithCode(
        player.id,
        player.username,
        code,
      );
      Log.info(game);

      return ResultSuccess(GameModel.fromJson(game));
    } catch (_) {
      Log.info(_);
      return ResultError(const ServerFailure('Failed to create game'));
    }
  }
}