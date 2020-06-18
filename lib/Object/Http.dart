import 'package:http/http.dart' as http;

import 'dart:convert';

fetch(api, body) {
  return http.post(
    "http://58.229.240.20:9070/api/" + api,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json', 'charset': 'utf-8'},
  );
}
