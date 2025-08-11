import 'package:my_social/model/common/base_result.dart';

class ShortVideoInfoResult extends BaseResult {
  // 视频ID
  String videoId;
  // 视频地址URL
  String videoUrl;
  // 作者头像URL
  String authorThumbUrl;
  // 作者昵称
  String authorNickName;
  // 标题
  String caption;
  // 描述
  String description;
  // 创建时间
  int commentCount;
  // 点赞数
  int diggCount;
  // 分享数
  int shareCount;
  // 收藏数
  int collectCount;
  // 播放数
  int playCount;
  // 创建时间
  int createTime;

  ShortVideoInfoResult({
    required this.videoId,
    required this.videoUrl,
    required this.authorThumbUrl,
    required this.authorNickName,
    required this.caption,
    required this.description,
    required this.commentCount,
    required this.diggCount,
    required this.shareCount,
    required this.collectCount,
    required this.playCount,
    required this.createTime,
  });

  factory ShortVideoInfoResult.empty() => ShortVideoInfoResult(
    videoId: '',
    videoUrl: '',
    authorThumbUrl: '',
    authorNickName: '',
    caption: '',
    description: '',
    commentCount: 0,
    diggCount: 0,
    shareCount: 0,
    collectCount: 0,
    playCount: 0,
    createTime: 0,
  );

  factory ShortVideoInfoResult.fromJson(Map<String, dynamic> json) {
    return ShortVideoInfoResult(
      videoId: json["videoId"],
      videoUrl: json["videoUrl"],
      authorThumbUrl: json["authorThumbUrl"],
      authorNickName: json["authorNickName"],
      caption: json["caption"],
      description: json["description"],
      commentCount: json["commentCount"],
      diggCount: json["diggCount"],
      shareCount: json["shareCount"],
      collectCount: json["collectCount"],
      playCount: json["playCount"],
      createTime: json["createTime"],
    );
  }

  Map<String, dynamic> toJson() => {
    "videoId": videoId,
    "videoUrl": videoUrl,
    "authorThumbUrl": authorThumbUrl,
    "authorNickName": authorNickName,
    "caption": caption,
    "description": description,
    "commentCount": commentCount,
    "diggCount": diggCount,
    "shareCount": shareCount,
    "collectCount": collectCount,
    "playCount": playCount,
    "createTime": createTime,
  };
}