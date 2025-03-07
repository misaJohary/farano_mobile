class PlayerEntity {
  final String id;
  final String username;

  const PlayerEntity({
    required this.id,
    required this.username,
  });

  factory PlayerEntity.first() => const PlayerEntity(
    id: 'P1',
    username: 'Player 1',
  );

  factory PlayerEntity.second() => const PlayerEntity(
    id: 'P2',
    username: 'Player 2',
  );

  List<Object> get props => [id, username];
}