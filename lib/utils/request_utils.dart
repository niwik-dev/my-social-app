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
  static ProviderContainer container = ProviderContainer();

  static Dio getInstance(){
    _dio = Dio();
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    return _dio;
  }

  static Future<Response> get(String url) async {
    String? accessToken = container.read(loginUserStoreProvider).accessToken;
    if(accessToken != null){ 
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
    }
    
    return await _dio.get(url);
  }

  static Future<Response> post(String url, dynamic data) async {
    String? accessToken = container.read(loginUserStoreProvider).accessToken;
    if(accessToken != null){ 
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
    }

    return await _dio.post(url, data: data);
  }

  static Future<Response> put(String url, dynamic data) async {
    String? accessToken = container.read(loginUserStoreProvider).accessToken;
    if(accessToken != null){ 
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
    }

    return await _dio.put(url, data: data);
  }

  static Future<Response> delete(String url) async {
    String? accessToken = container.read(loginUserStoreProvider).accessToken;
    if(accessToken != null){ 
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
    }

    return await _dio.delete(url);
  }

  static Future<Response> patch(String url, dynamic data) async {
    String? accessToken = container.read(loginUserStoreProvider).accessToken;
    if(accessToken != null){ 
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
    }

    return await _dio.patch(url, data: data);
  }

  static Future<Response> head(String url) async {
    String? accessToken = container.read(loginUserStoreProvider).accessToken;
    if(accessToken != null){ 
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
    }

    return await _dio.head(url);
  }
}