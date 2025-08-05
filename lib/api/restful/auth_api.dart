import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../../model/store/login_user.dart';
import '../../store/login/login_store.dart';
import '../../utils/base64_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthApi{
  // 单例模式
  static final AuthApi _instance = AuthApi._internal();
  factory AuthApi() => _instance;

  // 获取登录用户信息 存储状态
  AuthApi._internal();

  // 登录接口地址
  static const String baseUrl = "http://127.0.0.1:8989";

  static bool isClientInitialized = false;
  static late Dio httpClient;

  Dio getClient(){
    if(!isClientInitialized){
      httpClient = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          responseType: ResponseType.json,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      isClientInitialized = true;
    }
    return httpClient;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await getClient().get(
      path,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> post(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? data}) async {
    final response = await getClient().post<Map<String, dynamic>>(
      path,
      data: data,
    );
    return response;
  }

  Future<Image> fetchCaptcha(WidgetRef ref) async{
    String url = "/api/v1/auth/captcha";
    Response response = await get(url);
    String base64 = response.data["data"]["captchaBase64"];

    ref.watch(loginUserStoreProvider.notifier).setLoginUser(
      LoginUser(
        captchaKey: response.data["data"]["captchaKey"],
      )
    );
    return Base64Utils.base64ToImage(base64);
  }

  Future<void> sendSmsCode(String phone) async{
    String url = "/api/v1/auth/login/sms/code?mobile=$phone";
    await post(url);
  }

  Future<bool> login(
    WidgetRef ref,
    {
    required String username,
    required String password,
    required String captcha
  }) async{
    String url = "/api/v1/auth/login";
    Response response = await post('$url?username=$username&password=$password');
    if(response.statusCode == 200){
      if(response.data["code"] == "00000"){
        ref.watch(loginUserStoreProvider.notifier).setLoginUser(
          LoginUser(
            username: username,
            isLoggedIn: true,
            accessToken: response.data?["data"]["accessToken"],
            refreshToken: response.data?["data"]["refreshToken"],
          )
        );
        return true;
      }
    }
    return false;
  }
}