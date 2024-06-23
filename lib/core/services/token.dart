import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static SharedPreferences? userToken;
  static init() async {
    userToken = await SharedPreferences.getInstance();
  }

  static cacheBearerToken({required String token}) {
    userToken!.setString('token', token);
  }

static String? getBearerToken (){
  return userToken!.getString('token');
}
}
