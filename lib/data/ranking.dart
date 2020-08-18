class Ranking {
  final String singerUid;
  final int ranking;
  final int starCount;
  final String group;
  final String name;
  final String profileImage;
  final String date;

  Ranking.fromJson(Map<String, dynamic> map)
      : this.singerUid = map['singerUid'],
        this.ranking = map['ranking'],
        this.starCount = map['starCount'],
        this.group = map['group'],
        this.name = map['name'],
        this.profileImage = map['profileImage'],
        this.date = map['date'];

  Map<String, dynamic> toMap() {
    return {
      'singerUid': this.singerUid,
      'ranking': this.ranking,
      'starCount': this.starCount,
      'group': this.group,
      'name': this.name,
      'profileImage': this.profileImage,
      'date': this.date,
    };
  }
}
