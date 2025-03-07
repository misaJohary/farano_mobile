import 'package:farano/game/domain/repositories/game_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/game_service.dart';
import '../../../core/utils/failure.dart';
import '../../../core/utils/multi_result.dart';
import '../../domain/entities/game_entity.dart';
import '../models/game_model.dart';

@LazySingleton(as: GameRepository)
class GameRepositoryImpl implements GameRepository{
  final GameService _gameService;

  GameRepositoryImpl(this._gameService);

  @override
  Future<MultipleResult<Failure, GameEntity>> joinGame(String gameId) async {
    try {
      final game = await _gameService.getGameById(
        gameId
      );

      if(game != null) {
        return ResultSuccess(GameModel.fromJson(game));
      }else{
        return ResultError(const ServerFailure('Failed to create game'));
      }
    } catch (_) {
      return ResultError(const ServerFailure('Failed to create game'));
    }
  }
}