import 'package:flutter/foundation.dart';
import 'package:my_social/model/common/base_result.dart';

class ShortVideoCommentResult extends BaseResult {
  /// 评论id
  String commentId;
  /// 父评论id
  String? parentId;
  /// 评论内容
  String content;
  /// 视频id
  String videoId;
  /// 用户id
  String userId;
  /// 用户昵称
  String userName;
  /// 用户头像
  String userAvatar;
  /// 用户ip
  String ipLocation;
  /// 子评论数
  int commentsCount;
  /// 点赞数
  int diggCount;
  /// 创建时间
  int time;
  /// 标签
  List<String> labels;

  ShortVideoCommentResult({
    required this.commentId,
    required this.content,
    required this.videoId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.ipLocation,
    required this.commentsCount,
    required this.diggCount,
    required this.time,
    this.labels = const []
  });

  factory ShortVideoCommentResult.fromJson(Map<String,dynamic> json) {
    return ShortVideoCommentResult(
      commentId: json['commentId'],
      content: json['content'],
      videoId: json['videoId'],
      userId: json['userId'],
      userName: json['userName'],
      userAvatar: json['userAvatar'],
      ipLocation: json['ipLocation'],
      commentsCount: json['commentsCount'],
      diggCount: json['diggCount'],
      time: int.parse(json['time']),
      labels: json['labels'].map<String>((x) => x.toString()).toList(),
    );
  }
}