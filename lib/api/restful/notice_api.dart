import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/model/common/page_response.dart';
import 'package:my_social/model/request/notice_page_body.dart';
import 'package:my_social/model/response/notice_detail_result.dart';
import 'package:my_social/model/response/notice_result.dart';
import 'package:my_social/utils/request_utils.dart';

class NoticeApi {
  // 单例模式
  static final NoticeApi _instance = NoticeApi._internal();
  factory NoticeApi() => _instance;
  NoticeApi._internal();

  Future<NoticePageRsult> getNoticePage(WidgetRef ref,NoticePageBody body) async{
    String url = '/api/v1/notices/my-page';
    Response response = await AuthRequestUtils.get(ref,url);
    return NoticePageRsult.fromJson(response.data);
  }

  Future<NoticeDetailResult> getNoticeDetail(WidgetRef ref,String noticeId) async{
    String url = '/api/v1/notices/$noticeId/detail';
    Response response = await AuthRequestUtils.get(ref,url);
    return NoticeDetailResult.fromJson(response.data);
  }
}