import 'dart:convert';

class CampeaoJson {
  static dynamic decode(List<int> jsonBodyBytes) {
    return json.decode(utf8.decode(jsonBodyBytes));
  }

  static String encode(Object? jsonBody) {
    return json.encode(jsonBody);
  }
}