class TrophyGroup {
  String name;
  String iconUrl;
  String groupId;

  TrophyGroup(this.name, this.iconUrl, this.groupId);

  TrophyGroup.fromJson(Map<String, dynamic> json): this.name = json['name'], this.iconUrl = json['icon'], this.groupId = json['group_id'];
}