import 'package:equatable/equatable.dart';

class MatchEntity extends Equatable{
  const MatchEntity({
    required this.id,
    required this.code,
    this.hostName,
    this.config,
  });

  final String id;
  final String code;
  final String? hostName;
  final Map<String, dynamic>? config;

  @override
  List<Object?> get props => [id, code, hostName, config];
}