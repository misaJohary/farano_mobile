// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => MatchModel(
      id: json['id'] as String,
      code: json['code'] as String,
      hostName: json['hostName'] as String?,
      config: json['config'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MatchStatusEnumMap, json['status']) ??
          MatchStatus.waiting,
      currentGameId: json['currentGameId'] as String?,
    );

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hostName': instance.hostName,
      'config': instance.config,
      'status': _$MatchStatusEnumMap[instance.status]!,
      'currentGameId': instance.currentGameId,
    };

const _$MatchStatusEnumMap = {
  MatchStatus.waiting: 'waiting',
  MatchStatus.player2Entered: 'player2Entered',
  MatchStatus.gameCreated: 'gameCreated',
  MatchStatus.playing: 'playing',
  MatchStatus.paused: 'paused',
  MatchStatus.completed: 'completed',
  MatchStatus.abandoned: 'abandoned',
};
