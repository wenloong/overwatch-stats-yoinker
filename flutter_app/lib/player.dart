class Player {
  final String playerName;

  final int skillRating;

  Player(this.playerName, this.skillRating);

  Player.fromJson(Map<String, dynamic> json)
    : playerName = json['name'],
      skillRating = json['rating'];

  Map<String, dynamic> toJson() =>
    {
      'username': playerName,
      'competitive/tank/rank': skillRating
    };
}