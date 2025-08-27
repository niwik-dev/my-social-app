import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/model/common/page_response.dart';
import 'package:my_social/model/response/note_comment_result.dart';
import 'package:my_social/model/response/note_info_result.dart';
import 'package:my_social/utils/request_utils.dart';

class NoteApi{
  // 单例模式
  static final NoteApi _instance = NoteApi._internal();
  factory NoteApi() => _instance;
  NoteApi._internal();

  Future<List<NoteInfoResult>?> fetchNewNoteInfo(WidgetRef ref) async {
    String uri = "/api/v1/note/fetch";
    Response response = await AuthRequestUtils.get(
      ref,
      uri
    );
    if(response.statusCode != 200){
      return null;
    }
    return response.data["data"].map<NoteInfoResult>((x) => NoteInfoResult.fromJson(x)).toList();
  }

  Future<PageResponse<NoteInfoResult>?> getNoteInfoPage(WidgetRef ref,PageRequest pageRequest) async {
    String uri = "/api/v1/note/page";
    Response response = await AuthRequestUtils.post(
      ref,
      uri,
      pageRequest.toJson(),
    );
    if(response.statusCode != 200){
      return null;
    }
    return PageResponse<NoteInfoResult>.fromJson(
      response.data,
      (json) => NoteInfoResult.fromJson(json),
    );
  }

  Future<NoteInfoResult?> getNoteInfoById(WidgetRef ref,String noteId) async {
    String uri = "/api/v1/note/one";
    Response response = await AuthRequestUtils.get(
      ref, uri, 
      params: {
        "noteId": noteId
      }
    );
    if(response.statusCode != 200){
      return null;
    }
    return NoteInfoResult.fromJson(
      response.data["data"],
    );
  }

  Future<List<NoteCommentResult>> getNoteCommentList(WidgetRef ref,{
    required String noteId,
    required int pageNum,
    required int pageSize
  }) async { 
    String uri = "/api/v1/note/comments";
    Response response = await AuthRequestUtils.post(
      ref,
      uri,
      {
        "noteId": noteId,
        "pageNum": pageNum,
        "pageSize": pageSize,
      }
    );
    var data = response.data["data"];
    List<NoteCommentResult> result = [];
    for (var item in data) { 
      result.add(NoteCommentResult.fromJson(item));
    }
    return result;
  }
}