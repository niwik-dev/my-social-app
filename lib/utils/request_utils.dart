import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../store/login/login_store.dart';

class RequestUtils{
  static Dio _dio = getInstance();

  static Dio getInstance(){
    _dio = Dio();
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    return _dio;
  }

  static Future<Response> get(String url) async {
    return await _dio.get(url);
  }

  static Future<Response> post(String url, dynamic data) async {
    return await _dio.post(url, data: data);
  }

  static Future<Response> put(String url, dynamic data) async {
    return await _dio.put(url, data: data);
  }

  static Future<Response> delete(String url) async {
    return await _dio.delete(url);
  }

  static Future<Response> patch(String url, dynamic data) async {
    return await _dio.patch(url, data: data);
  }

  static Future<Response> head(String url) async {
    return await _dio.head(url);
  }
}

class AuthRequestUtils{
  static Dio _dio = getInstance();

  // 用于测试时使用，模拟登录
  static bool isMock = false;
  static String mockToken = "";

  static Dio getInstance(){
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://127.0.0.1:8989",
        validateStatus: (status) {
          return true;
        },
      ),
    );
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    // https://github.com/cfug/dio/issues/2056#issuecomment-1840522128

    // 如果请求响应401，则立即跳转页面
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onResponse: (response, handler) {
    //     if(response.statusCode == 401){
    //       // 跳转到登录页面
    //       AppRouterHolder().getRouter().go('/');
    //     }
    //     return handler.next(response);
    //   },
    // ));
    return _dio;
  }

  static void setMockToken(String token){
    isMock = true;
    mockToken = token;
    _dio.options.headers["Authorization"] = "Bearer $mockToken";
  }

  static void setTokenFromProvider(WidgetRef ref) async {
    isMock = false;
    String? accessToken = ref.read(loginUserStoreProvider).accessToken;
    if(accessToken != null){ 
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
    }
  }

  static void readToken(WidgetRef ref){
    if(isMock){ 
      _dio.options.headers["Authorization"] = "Bearer $mockToken";
    } else { 
      String? accessToken = ref.read(loginUserStoreProvider).accessToken;
      if(accessToken != null){ 
        _dio.options.headers["Authorization"] = "Bearer $accessToken";
      }
    }
  }

  static Future<Response> get(WidgetRef ref,String url,{Map<String,dynamic>? params}) async {
    readToken(ref);
    return await _dio.get(url,queryParameters: params);
  }

  static Future<Response> post(WidgetRef ref,String url, dynamic data) async {
    readToken(ref);
    return await _dio.post(url, data: data);
  }

  static Future<Response> put(WidgetRef ref,String url, dynamic data) async {
    readToken(ref);
    return await _dio.put(url, data: data);
  }

  static Future<Response> delete(WidgetRef ref,String url) async {
    readToken(ref);
    return await _dio.delete(url);
  }

  static Future<Response> patch(WidgetRef ref,String url, dynamic data) async {
    readToken(ref);
    return await _dio.patch(url, data: data);
  }

  static Future<Response> head(WidgetRef ref,String url) async {
    readToken(ref);
    return await _dio.head(url);
  }
}