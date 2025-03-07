import 'package:equatable/equatable.dart';

abstract class GameEntity extends Equatable {
  const GameEntity({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}