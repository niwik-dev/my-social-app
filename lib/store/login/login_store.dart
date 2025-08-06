import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_social/service/pref_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/store/login_user.dart';

part 'login_store.g.dart';

@riverpod
class LoginUserStore extends _$LoginUserStore {
  @override
  LoginUser build() {
    return LoginUser();
  }

  Future<LoginUser?> loadFromPerfs() async{
    PrefService prefService = PrefService();
    LoginUser? loginUser = await prefService.loadLoginUser();
    if(loginUser == null){
      return null;
    }
    state = loginUser;
    return loginUser;
  }

  void setLoginUser(LoginUser user){
    state = user;
  }

  void logout(){
    state = LoginUser(
      isLoggedIn: false,
      username: '游客',
      avatarUrl: null,
      accessToken: null,
      captchaKey: null
    );
  }
}
