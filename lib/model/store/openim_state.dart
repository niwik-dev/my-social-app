class OpenIMState{
  // 授权token
  String token;
  // 过期时间（单位：秒）
  int expireTimeSeconds;

  OpenIMState({
    this.token = '',
    this.expireTimeSeconds = 0
  });

  factory OpenIMState.fromJson(Map<String, dynamic> json) => OpenIMState(
    token: json['token'],
    expireTimeSeconds: json['expireTimeSeconds']
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'expireTimeSeconds': expireTimeSeconds
  };
}