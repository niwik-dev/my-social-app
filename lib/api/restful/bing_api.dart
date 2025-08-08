import 'package:dio/dio.dart';

class BingApi{
  // 单例模式
  static final BingApi _instance = BingApi._internal();
  factory BingApi() => _instance;
  BingApi._internal();

  bool isInit = false;
  late Dio _dio;

  Dio getClient(){
    if(!isInit){
      _dio = Dio();
      _dio.options.baseUrl = 'https://cn.bing.com';
      isInit = true;
    }
    return _dio;
  }

  Future<String> getBingImage() async {
    var response = await getClient().get('https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN');
    return 'https://cn.bing.com${response.data['images'][0]['url']}';
  }
}