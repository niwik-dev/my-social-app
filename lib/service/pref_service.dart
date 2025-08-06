import 'package:my_social/model/store/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PrefService{
  // 单例模式
  static final PrefService _instance = PrefService._internal();

  factory PrefService() => _instance;

  PrefService._internal();

  // 存储用户信息
  static const String keyLoginUser = "login_user";


  Future<void> saveLoginUser(LoginUser loginUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyLoginUser, jsonEncode(loginUser.toJson()));
  }

  Future<LoginUser?> loadLoginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(keyLoginUser);
    if(userJson == null){
      return null;
    }
    return LoginUser.fromJson(jsonDecode(userJson));
  }

  void clearLoginUser() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(keyLoginUser);
    });
  }
}