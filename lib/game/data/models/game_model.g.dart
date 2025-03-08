// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: json['id'] as String?,
      currentWord: json['currentWord'] as String? ?? '',
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => PlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPlayerId: json['currentPlayerId'] as String? ?? '',
      status: $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
          GameStatus.playing,
      currentGameId: json['currentGameId'] as String?,
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'id': instance.id,
      'currentWord': instance.currentWord,
      'currentPlayerId': instance.currentPlayerId,
      'status': _$GameStatusEnumMap[instance.status]!,
      'currentGameId': instance.currentGameId,
      'players': instance.players,
    };

const _$GameStatusEnumMap = {
  GameStatus.active: 'active',
  GameStatus.playing: 'playing',
  GameStatus.paused: 'paused',
  GameStatus.completed: 'completed',
};
