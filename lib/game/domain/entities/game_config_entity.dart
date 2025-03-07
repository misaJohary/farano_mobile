import 'package:equatable/equatable.dart';

class GameConfigEntity extends Equatable{
  final int timePerTurn;
  final int maxRematchCount;

  const GameConfigEntity({
    required this.timePerTurn,
    required this.maxRematchCount,
  });

  factory GameConfigEntity.byDefault() => const GameConfigEntity(
    timePerTurn: 5,
    maxRematchCount: 5,
  );

  @override
  List<Object?> get props => [timePerTurn, maxRematchCount];
}
