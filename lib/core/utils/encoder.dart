import 'dart:convert';

class CustomEncoder {
  static base64Encode({required String name, required String password}) =>
      "Basic ${base64.encode(utf8.encode("$name:$password"))}";
}
