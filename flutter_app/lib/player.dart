class Player {
  final String playerName;

  final int skillRating;

  final String icon;

  Player(this.playerName, this.skillRating, this.icon);

  Player.fromJson(Map<String, dynamic> json)
    : playerName = json['name'],
      skillRating = json['rating'],
      icon = json['icon'];


  Map<String, dynamic> toJson() =>
    {
      'username': playerName,
      'competitive/tank/rank': skillRating
    };
}