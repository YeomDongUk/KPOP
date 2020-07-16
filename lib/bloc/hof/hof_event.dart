import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class HofEvent extends Equatable {
  const HofEvent();
}

class HofMonthlyLoad extends HofEvent {
  final String typeCode;
  final String genderCode;
  const HofMonthlyLoad({
    @required this.typeCode,
    @required this.genderCode,
  });

  @override
  List<Object> get props => [typeCode, genderCode];

  @override
  String toString() =>
      'HofButtonPressed { typeCode: $typeCode, genderCode: $genderCode }';
}

class HofDailyLoad extends HofEvent {
  final String typeCode;
  final String genderCode;
  final int month;
  final String orderByCode;
  const HofDailyLoad({
    @required this.typeCode,
    @required this.genderCode,
    @required this.month,
    @required this.orderByCode,
  });

  @override
  List<Object> get props => [typeCode, genderCode];

  @override
  String toString() =>
      'HofButtonPressed { typeCode: $typeCode, genderCode: $genderCode }';
}
