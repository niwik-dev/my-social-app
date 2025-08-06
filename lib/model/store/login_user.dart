import 'dart:convert';

class LoginUser{
  String username;
  String? avatarUrl;
  bool isLoggedIn;
  String? accessToken;
  String? refreshToken;
  String? captchaKey;

  LoginUser({
    this.username = '游客',
    this.avatarUrl,
    this.isLoggedIn = false,
    this.accessToken,
    this.refreshToken,
    this.captchaKey,
  });

  LoginUser copyWith({
    String? username,
    String? avatarUrl,
    bool? isLoggedIn,
    String? accessToken,
    String? refreshToken,
    String? captchaKey,
  }){
    return LoginUser(
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      captchaKey: captchaKey ?? this.captchaKey,
    );
  }

  factory LoginUser.fromJson(Map<String, dynamic> userMap) {
    return LoginUser(
      username: userMap['username'] ?? '游客',
      avatarUrl: userMap['avatarUrl'],
      isLoggedIn: userMap['isLoggedIn'] ?? false,
      accessToken: userMap['accessToken'],
      refreshToken: userMap['refreshToken'],
      captchaKey: userMap['captchaKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'avatarUrl': avatarUrl,
      'isLoggedIn': isLoggedIn,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'captchaKey': captchaKey,
    };
  }

  String toJsonSting(){
    return jsonEncode(toJson());
  }
}