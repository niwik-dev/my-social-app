import 'package:my_social/model/common/base_result.dart';

class NoteCommentResult extends BaseResult{
    /// 评论ID
    String id;
    /// 父级评论ID
    String? parentId;
    /// 评论内容
    String content;
    /// 评论时间
    String ipLocation;
    /// 点赞数
    int likeCount;
    /// 子评论数
    int subCommentCount;
    /// 笔记ID
    String noteId;
    /// 用户ID
    String userId;
    /// 用户头像
    String userAvatar;
    /// 用户昵称
    String userName;
    /// 子评论游标
    dynamic subCommentCursor;
    /// 创建时间
    int time;

    NoteCommentResult({
        required this.id,
        required this.parentId,
        required this.content,
        required this.ipLocation,
        required this.likeCount,
        required this.subCommentCount,
        required this.noteId,
        required this.userId,
        required this.userAvatar,
        required this.userName,
        required this.subCommentCursor,
        required this.time,
    });

    factory NoteCommentResult.empty() => NoteCommentResult(
        id: "",
        parentId: "",
        content: "",
        ipLocation: "",
        likeCount: 0,
        subCommentCount: 0,
        noteId: "",
        userId: "",
        userAvatar: "",
        userName: "",
        subCommentCursor: "",
        time: 0,
    );

    factory NoteCommentResult.fromJson(Map<String, dynamic> json) => NoteCommentResult(
        id: json["commentId"],
        parentId: json["parentId"],
        content: json["content"],
        ipLocation: json["ipLocation"],
        likeCount: json["likeCount"],
        subCommentCount: json["subCommentCount"],
        noteId: json["noteId"],
        userId: json["userId"],
        userAvatar: json["userAvatar"],
        userName: json["userName"],
        subCommentCursor: json["subCommentCursor"],
        time: int.parse(json["time"]),
    );
}