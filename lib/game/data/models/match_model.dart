import '../../domain/entities/match_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'match_model.g.dart';

@JsonSerializable()
class MatchModel extends MatchEntity {
  const MatchModel({
    required super.id,
    required super.code,
    super.hostName,
    super.config,
    super.status,
    super.currentGameId,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => _$MatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchModelToJson(this);
}