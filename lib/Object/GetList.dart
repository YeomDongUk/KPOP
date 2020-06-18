import 'dart:convert';
import 'dart:async';
import 'package:kpop/Object/Http.dart';

dynamic getList({String api, String typeCode, String genderCode, String loginToken}) async {
  final res = await fetch(api, {
    'loginToken': loginToken,
    'typeCode': typeCode,
    'genderCode': genderCode,
  });

  var body = jsonDecode(res.body);

  if (body["success"]) {
    await Future.delayed(const Duration(milliseconds: 500));
    return body["singer"];
  }
}

dynamic getMonthList(
    {String api,
    String typeCode,
    String genderCode,
    int month,
    String orderByCode,
    String loginToken}) async {
  final res = await fetch(api, {
    'loginToken': loginToken,
    'typeCode': typeCode,
    'genderCode': genderCode,
    'month': month,
    'orderByCode': orderByCode,
  });

  var body = jsonDecode(res.body);

  if (body["success"]) {
    await Future.delayed(const Duration(milliseconds: 500));
    return body["singer"];
  }
}
