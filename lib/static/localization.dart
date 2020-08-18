import 'dart:ui';

class Localization {
  final Locale locale;
  Localization(this.locale);

  static Map _local = {
    'en': {
      "email": "E-mail address",
      "password": "Password",
      "login": "LOGIN",
      "findPw": "Forget Password?",
      "sns": "or login with",
      "SIGNUP": "SIGN UP",
      "Signup": "Sign up",
      "emailWarning": "English, Numbers(maximum 30 Characters)",
      "passWarning": "English, Numbers each at least one (8-20 Characters)",
      "NicName": "Nic Name",
      "nicWarning": "* English, Numbers(3-12 Characters)",
      "Recommender": "Recommender",
      "recoWarning": "* Optional",
      "recommender": "Recommender (Nic Name)",
      "Solo": "Solo",
      "Group": "Group",
      "HallofFame": "Hall of Fame",
      "AngelofHonor": "Angel of Honor",
      "Individual30Days": "Individual\n 30 Days",
      "Group30Days": "Group\n 30 Days",
      "Individual": "Individual",
      "Boy": "Boy",
      "Girl": "Girl",
      "Boys": "Boys",
      "Girls": "Girs",
      "Menu": "Menu",
      "Home": "Home",
      "MyStars": "My Stars",
      "MyActivities": "My Activites",
      "Notice": "Notice",
      "Events": "Events",
      "Board": "Board",
      "IdolQuiz": "Idol Quiz",
      "Stars": "Stars",
      "ItemStore": "ItemStore",
      "MusicVideo": "Music Video",
      "Settings": "Settings",
      "Language": "Language",
      "ShareThisApp": "Share this app",
      "EverStars": "Ever Stars",
      "DailyStars": "Daliy Stars",
      "MyAccumulatedVotes": "My Accumulated Votes",
      "Everstarcollectedtoday": "Ever star collected today",
      "StarUsageHistory": "Star Usage History",
      "StarAccumulationHistory": "Star Accumulation History",
      "SeeVideoAd": "See video ad",
      "Get36Stars": "Get 36 Stars",
      "StarRefillStation": "Star Refill Station",
      "Joined": "Joined",
      "AccumulatedVotes": "Accumulated Votes",
      "StarChargingStation": "Star Charging Station"
    },
    'ko': {
      "email": "이메일주소",
      "password": "비밀번호",
      "login": "로그인",
      "findPw": "비밀번호를 잊어버리셨습니까?",
      "sns": "소셜로그인",
      "SIGNUP": "회원가입",
      "Signup": "회원가입",
      "emailWarning": "ID 규정",
      "passWarning": "비밀번호 규정",
      "NicName": "닉네임",
      "nicWarning": "* 영어, 숫자 혼합 (3-12문자)",
      "Recommender": "추천인",
      "recoWarning": "* 필수사항아님",
      "recommender": "추천인 (닉네임)",
      "Solo": "솔로",
      "Group": "그룹",
      "HallofFame": "명예의전당",
      "AngelofHonor": "나의 천사"
    }
  };

  String get email => _local[locale.languageCode]['email'];
  String get password => _local[locale.languageCode]['password'];
  String get login => _local[locale.languageCode]['login'];
  String get findPw => _local[locale.languageCode]['findPw'];
  String get signUp => _local[locale.languageCode]['SIGNUP'];
  String get individual30Days =>
      _local[locale.languageCode]['Individual30Days'];
  String get group30Days => _local[locale.languageCode]['Group30Days'];
  String get individual => _local[locale.languageCode]['Individual'];
  String get group => _local[locale.languageCode]['Group'];
  String get solo => _local[locale.languageCode]['Solo'];
  String get hallofFame => _local[locale.languageCode]['HallofFame'];
  String get angelofHonor => _local[locale.languageCode]['AngelofHonor'];
  String get boy => _local[locale.languageCode]['Boy'];
  String get girl => _local[locale.languageCode]['Girl'];
  String get boys => _local[locale.languageCode]['Boys'];
  String get girls => _local[locale.languageCode]['Girls'];
  String get menu => _local[locale.languageCode]['Menu'];
  String get myStars => _local[locale.languageCode]['MyStars'];
  String get starRefillStation =>
      _local[locale.languageCode]['StarRefillStation'];
}
