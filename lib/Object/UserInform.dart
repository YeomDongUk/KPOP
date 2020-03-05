//회원가입용

class UserInform {
  String registTypeCode;
  String id;
  String password;
  String nickname;
  String profileImage;
  String platformTypeCode;
  String recomMemberNickname;
  String _pushToken;
  UserInform({
    this.registTypeCode,
    this.id,
    this.password,
    this.nickname,
    this.profileImage,
    this.recomMemberNickname,
    this.platformTypeCode,
  });

  set setTokken(String token) => _pushToken = token;
  get getTokken => _pushToken;
  Map<String, dynamic> toJson() => {
        'registTypeCode': registTypeCode,
        'id': id,
        'password': password,
        'nickname': nickname,
        'profileImage': profileImage,
        'platformTypeCode': platformTypeCode,
        'recomMemberNickname': recomMemberNickname,
        'pushToken': getTokken
      };
}
