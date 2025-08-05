import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/model/common/page_response.dart';
import 'package:my_social/model/response/short_video_info_result.dart';
import 'package:my_social/utils/request_utils.dart';

class ShortVideoApi {
  // 单例模式
  static final ShortVideoApi _instance = ShortVideoApi._internal();
  factory ShortVideoApi() => _instance;
  ShortVideoApi._internal();

  Future<List<ShortVideoInfoResult>?> fetchNewShortVideoInfo(WidgetRef ref) async {
    String uri = "/api/v1/short_video/fetch";
    Response response = await AuthRequestUtils.get(
      ref,
      uri
    );
    if(response.statusCode != 200){
      return null;
    }
    return response.data["data"].map<ShortVideoInfoResult>((x) => ShortVideoInfoResult.fromJson(x)).toList();
  }

  Future<PageResponse<ShortVideoInfoResult>?> getShortVideoInfoPage(WidgetRef ref, PageRequest pageRequest) async {
    String uri = "/api/v1/short-video/page";
    Response response = await AuthRequestUtils.post(
      ref,
      uri,
      pageRequest.toJson(),
    );
    if(response.statusCode != 200){
      return null;
    }
    return PageResponse.fromJson(response.data, (json) => ShortVideoInfoResult.fromJson(json));
  }

  Future<ShortVideoInfoResult?> getShortVideoInfoById(WidgetRef ref, String shortVideoId) async {
    String uri = "/api/v1/short_video/one";
    Response response = await AuthRequestUtils.get(
      ref,
      uri,
      params: {
        "shortVideoId": shortVideoId
      }
    );
    if(response.statusCode != 200){
      return null;
    }
    return ShortVideoInfoResult.fromJson(
      response.data["data"],
    );
  }
}