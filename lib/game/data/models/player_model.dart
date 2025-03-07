import 'package:farano/game/domain/entities/player_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable()
class PlayerModel extends PlayerEntity {
  PlayerModel({
    required super.id,
    required super.username,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => _$PlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
