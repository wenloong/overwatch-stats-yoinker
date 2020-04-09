class Player {
  final String playerName;
  final int skillRatingGeneral;
  //final int skillRatingTank;
  //final int skillRatingDamage;
 // final int skillRatingSupport;
  final String icon;
  

  Player(this.playerName, this.skillRatingGeneral, this.icon/*, this.skillRatingTank, this.skillRatingDamage,this.skillRatingSupport*/);

  Player.fromJson(Map<String, dynamic> json)
    : playerName = json['name'],
      skillRatingGeneral = json['rating'],
      icon = json['icon'];

  Map<String, dynamic> toJson() =>
    {
      'username': playerName,
      'competitive/tank/rank': skillRatingGeneral
      
    };
}