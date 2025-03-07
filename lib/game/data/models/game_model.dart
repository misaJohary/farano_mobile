import 'package:farano/game/data/models/player_model.dart';

import '../../domain/entities/game_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel extends GameEntity {
  const GameModel({
    required super.id,
    super.currentWord,
    this.players =const [],
    super.currentPlayerId,
    super.status,
  });

  @override
  final List<PlayerModel> players;

  factory GameModel.fromJson(Map<String, dynamic> json) =>
    _$GameModelFromJson(json);


  Map<String, dynamic> toJson() => _$GameModelToJson(this);

}
