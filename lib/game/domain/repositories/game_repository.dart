import 'package:farano/core/utils/multi_result.dart';
import 'package:farano/game/domain/entities/game_config_entity.dart';
import 'package:farano/game/domain/entities/match_entity.dart';
import 'package:farano/game/domain/entities/player_entity.dart';

import '../../../core/utils/failure.dart';
import '../entities/game_entity.dart';

abstract class GameRepository {
  Future<MultipleResult<Failure, MatchEntity>> createGame(
    PlayerEntity player,
    GameConfigEntity config,
  );

  Future<MultipleResult<Failure, GameEntity>> joinGame(
    PlayerEntity player,
    String code,
  );
}