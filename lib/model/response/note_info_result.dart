import 'package:my_social/model/common/base_result.dart';

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
    // 点赞数
    int likedCount;
    // 评论数
    int commentsCount;
    // 收藏数
    int collectedCount;
    // 浏览数
    int viewCount;
    // 分享数
    int sharedCount;
    // IP地址
    String ipLocation;
    // 图片列表
    List<String> imagesList;
    // 创建时间
    String? createTime;

    NoteInfoResult({
        required this.noteId,
        required this.coverUrl,
        required this.title,
        required this.userName,
        required this.userAvatar,
        required this.descr,
        required this.likedCount,
        required this.commentsCount,
        required this.collectedCount,
        required this.viewCount,
        required this.sharedCount,
        required this.ipLocation,
        required this.imagesList,
        required this.createTime,
    });

    factory NoteInfoResult.empty() => NoteInfoResult(
        noteId: '',
        coverUrl: '',
        title: '',
        userName: '',
        userAvatar: '',
        descr: '',
        likedCount: 0,
        commentsCount: 0,
        collectedCount: 0,
        viewCount: 0,
        sharedCount: 0,
        ipLocation: '',
        imagesList: [],
        createTime: '',
    );

    factory NoteInfoResult.fromJson(Map<String, dynamic> json) => NoteInfoResult(
        noteId: json["noteId"],
        coverUrl: json["coverUrl"],
        title: json["title"],
        userName: json["userName"],
        userAvatar: json["userAvatar"],
        descr: json["descr"],
        likedCount: json["likedCount"],
        collectedCount: json["collectedCount"],
        commentsCount: json["commentsCount"],
        viewCount: json["viewCount"],
        sharedCount: json["sharedCount"],
        ipLocation: json["ipLocation"],
        imagesList: List<String>.from(json["imagesList"].map((x) => x)),
        createTime: json["createTime"],
    );

    Map<String, dynamic> toJson() => {
        "noteId": noteId,
        "coverUrl": coverUrl,
        "title": title,
        "userName": userName,
        "userAvatar": userAvatar,
        "descr": descr,
        "likedCount": likedCount,
        "collectedCount": collectedCount,
        "commentsCount": commentsCount,
        "viewCount": viewCount,
        "ipLocation": ipLocation,
        "imagesList": List<dynamic>.from(imagesList.map((x) => x)),
        "createTime": createTime,
    };
}