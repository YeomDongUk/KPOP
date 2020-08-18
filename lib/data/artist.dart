import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  final int uid;
  final String typeCode;
  final String genderCode;
  final String name;
  final String profileImage;
  final String bannerImage;
  final int voteCount;
  final int starCount;
  final int rank;
  final String hofDt;
  final Map group;

  Artist.fromJson(Map<String, dynamic> map)
      : this.uid = map['uid'],
        this.typeCode = map['typeCode'],
        this.genderCode = map['genderCode'],
        this.name = map['name'],
        this.profileImage = map['profileImage'],
        this.bannerImage = map['bannerImage'],
        this.voteCount = map['voteCount'],
        this.starCount = map['starCount'],
        this.rank = map['rank'],
        this.hofDt = map['hofDt'],
        this.group = map['group'];

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'typeCode': this.typeCode,
      'genderCode': this.genderCode,
      'name': this.name,
      'profileImage': this.profileImage,
      'bannerImage': this.bannerImage,
      'voteCount': this.voteCount,
      'starCount': this.starCount,
      'rank': this.rank,
      'hofDt': this.hofDt,
      'group': this.group,
    };
  }

  @override
  List<Object> get props => [
        uid,
        typeCode,
        genderCode,
        name,
        profileImage,
        bannerImage,
        voteCount,
        starCount,
        rank,
        hofDt,
        group,
      ];

  @override
  String toString() => 'Artist ${this.toMap()}';
}
