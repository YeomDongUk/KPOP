import 'package:equatable/equatable.dart';

class Star extends Equatable {
  final int myStarCount;
  final int everStarCount;
  final int dailyStarCount;

  Star.fromJson(Map<String, dynamic> map)
      : this.myStarCount = map['myStarCount'],
        this.everStarCount = map['everStarCount'],
        this.dailyStarCount = map['dailyStarCount'];

  Map<String, dynamic> toMap() {
    return {
      'myStarCount': this.myStarCount,
      'everStarCount': this.everStarCount,
      'dailyStarCount': this.dailyStarCount,
    };
  }

  @override
  List<Object> get props => [
        myStarCount,
        everStarCount,
        dailyStarCount,
      ];

  @override
  String toString() => 'Star: ${this.toMap()}';
}
