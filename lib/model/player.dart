class Player {
  final String nickname;
  final String socketId;
  final double points;
  final String playerType;

  Player({
    required this.nickname,
    required this.socketId,
    required this.points,
    required this.playerType,
  });

  Player copyWith({
    String? nickname,
    String? socketId,
    double? points,
    String? playerType,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }

  Map<String, dynamic> toMap() => {
    'nickname': nickname,
    'socketId': socketId,
    'points': points,
    'playerType': playerType,
  };

  factory Player.fromMap(Map<String, dynamic> map) {
    final socketId = map['socketId'] ?? map['socketID'] ?? '';
    final pointsValue = map['points'] ?? 0;

    return Player(
      nickname: map['nickname'] ?? '',
      socketId: socketId.toString(),
      points: pointsValue is num ? pointsValue.toDouble() : 0.0,
      playerType: map['playerType'] ?? 'X',
    );
  }
}
