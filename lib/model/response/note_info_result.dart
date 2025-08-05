import 'dart:ffi';

import 'package:my_social/model/response/base_result.dart';

class NoteInfoResult extends BaseResult {
    // 帖子ID
    String noteId;
    // 封面URL
    String coverUrl;
    // 标题
    String title;
    // 作者昵称
    String userName;
    // 作者头像
    String userAvatar;
    // 描述
    String descr;
    // 创建时间
    String? createTime;

    NoteInfoResult({
        required this.noteId,
        required this.coverUrl,
        required this.title,
        required this.userName,
        required this.userAvatar,
        required this.descr,
        required this.createTime,
    });

    factory NoteInfoResult.empty() => NoteInfoResult(
        noteId: '',
        coverUrl: '',
        title: '',
        userName: '',
        userAvatar: '',
        descr: '',
        createTime: '',
    );

    factory NoteInfoResult.fromJson(Map<String, dynamic> json) => NoteInfoResult(
        noteId: json["noteId"],
        coverUrl: json["coverUrl"],
        title: json["title"],
        userName: json["userName"],
        userAvatar: json["userAvatar"],
        descr: json["descr"],
        createTime: json["createTime"],
    );

    Map<String, dynamic> toJson() => {
        "noteId": noteId,
        "coverUrl": coverUrl,
        "title": title,
        "userName": userName,
        "userAvatar": userAvatar,
        "descr": descr,
        "createTime": createTime,
    };
}