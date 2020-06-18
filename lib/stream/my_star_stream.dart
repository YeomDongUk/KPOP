import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:kpop/Object/Http.dart';

class MyStarStream {
  StreamController<Map<String, dynamic>> _streamController;
  Stream<Map<String, dynamic>> _stream;
  Stream<Map<String, dynamic>> get stream => _stream;
  MyStarStream() {
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
  }

  void getMyStar({String loginToken}) async {
    Response response = await fetch("IF016", {
      "loginToken": loginToken,
    });
    Map<String, dynamic> body = jsonDecode(response.body);
    if (response.statusCode == 200 && body['success'] == true) {
      _streamController.sink.add(body);
      print(body);
    } else {}
  }

  void dispose() {
    _streamController?.close();
  }
}
