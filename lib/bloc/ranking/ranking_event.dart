import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RankingEvent extends Equatable {
  const RankingEvent();
}

class RankingLoad extends RankingEvent {
  final String typeCode;
  final String genderCode;
  const RankingLoad({
    @required this.typeCode,
    @required this.genderCode,
  });

  @override
  List<Object> get props => [typeCode, genderCode];

  @override
  String toString() =>
      'RankingButtonPressed { typeCode: $typeCode, genderCode: $genderCode }';
}
