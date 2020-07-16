import 'package:kpop/data/star.dart';
import 'package:kpop/data/star_history.dart';

class MyStarDetail {
  final Star star;
  final int totalVote;
  final List<StarHistory> starUsageHistory;
  final List<StarHistory> starEarnHistory;

  const MyStarDetail({
    this.star,
    this.totalVote,
    this.starUsageHistory,
    this.starEarnHistory,
  });
}
