class User {
  final String registDt;
  final String registTypeCode;
  final String id;
  final String nickname;
  final String profileImage;
  final int level;
  final int totalVote;

  User.fromJson(Map<String, dynamic> map)
      : this.registDt = map['registDt'],
        this.registTypeCode = map['registTypeCode'],
        this.id = map['id'],
        this.nickname = map['nickname'],
        this.profileImage = map['profileImage'],
        this.level = map['level'],
        this.totalVote = map['totalVote'];

  Map<String, dynamic> toMap() {
    return {
      'registDt': this.registDt,
      'registTypeCode': this.registTypeCode,
      'id': this.id,
      'nickname': this.nickname,
      'profileImage': this.profileImage,
      'level': this.level,
      'totalVote': this.totalVote,
    };
  }
}
