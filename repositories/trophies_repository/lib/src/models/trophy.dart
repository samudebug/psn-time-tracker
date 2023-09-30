enum TrophyType { bronze, silver, gold, platinum }

class Trophy {
  String name;
  String description;
  String iconUrl;
  bool earned;
  String type;

  Trophy(this.name, this.description, this.iconUrl, this.earned, this.type);

  Trophy.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.description = json['description'],
        this.iconUrl = json['icon'],
        this.earned = json['earned'],
        this.type = json['type'];
}
