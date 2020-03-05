//사용용

class User {
  final String registTypeCode;
  final String id;
  final String nickname;
  final String profileImage;
  final String registDt;
  int level;
  int totalVote;
  User(
      {this.registTypeCode,
      this.id,
      this.nickname,
      this.profileImage,
      this.registDt,
      this.level,
      this.totalVote});

  User.fromJson(Map<String, dynamic> json)
      : registTypeCode = json["registTypeCode"],
        id = json["id"],
        nickname = json["nickname"],
        profileImage = json["profileImage"],
        registDt = json["registDt"],
        level = json["level"],
        totalVote = json["totalVote"];

  Map<String, dynamic> toJson() => {
        "registTypeCode": registTypeCode,
        "id": id,
        "nickname": nickname,
        "profileImage": profileImage,
        "registDt": registDt,
        "level": level,
        "totalVote": totalVote
        // ""
      };
}


User userProfile;