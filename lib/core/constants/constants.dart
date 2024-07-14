import 'dart:convert';

const wpV2EndPoint = "wp-json/wp/v2";

const String loginScreen = "/loginScreen";
const String mainScreen = "/mainScreen";
// const String postScreen = "/post";
// const String postsScreen = "/posts";
// const String profileScreen = "/profile";
// const String settingsScreen = "/settings";

makeBase64Encode({required String name, required String password}) =>
    "Basic ${base64.encode(utf8.encode("$name:$password"))}";
