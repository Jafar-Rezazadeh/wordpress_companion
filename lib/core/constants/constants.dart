const wpV2EndPoint = "wp-json/wp/v2";
const String loginScreen = "/login";
const String homeScreen = "/home";
// const String postScreen = "/post";
// const String postsScreen = "/posts";
// const String profileScreen = "/profile";
// const String settingsScreen = "/settings";

makeBase64Encode(String name, String password) =>
    "Basic ${base64.encode(utf8.encode("$name:$password"))}";
