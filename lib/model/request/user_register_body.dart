class UserBody{
  // 用户名
  String username;
  // 密码
  String password;
  // 昵称
  String nickname;
  // 性别
  int gender;
  // 手机号
  String mobile;
  // 头像
  String avatar;

  UserBody({
    this.username = "",
    this.password = "",
    this.nickname = "",
    this.gender = 0,
    this.mobile = "",
    this.avatar = ""
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "nickname": nickname,
      "gender": gender,
      "mobile": mobile,
      "avatar": avatar
    };
  }
}