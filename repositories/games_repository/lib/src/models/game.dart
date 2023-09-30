class Game {
  String name;
  String imageUrl;
  String playTime;
  String titleId;

  Game(this.name, this.imageUrl, this.playTime, this.titleId);

  Game.fromJson(Map<String, dynamic> json): this.name = json['name'], this.imageUrl = json['image_url'], this.titleId = json['title_id'], this.playTime = json['total_play_duration'];
}