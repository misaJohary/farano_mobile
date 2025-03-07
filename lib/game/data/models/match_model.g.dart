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
    );

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hostName': instance.hostName,
      'config': instance.config,
    };
