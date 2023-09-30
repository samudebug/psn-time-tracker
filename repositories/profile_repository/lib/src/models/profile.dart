class Profile {
  String username;
  String avatarUrl;

  Profile(this.username, this.avatarUrl);

  Profile.fromJson(Map<String, dynamic> json) : this.username = json['name'], this.avatarUrl = json['avatarUrl'];
}