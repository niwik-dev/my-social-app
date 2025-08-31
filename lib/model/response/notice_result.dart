import 'package:my_social/model/common/base_result.dart';

class NoticePageRsult extends BaseResult{
  List<NoticeResult> list;
  int total;
  NoticePageRsult({
    required this.list,
    required this.total,
  });

  factory NoticePageRsult.fromJson(Map<String, dynamic> json) => NoticePageRsult(
    list: json["data"]["list"] == null ? [] :
     List<NoticeResult>.from(json["data"]["list"].map((x) => NoticeResult.fromJson(x))),
    total: json["data"]["total"],
  );
}

class NoticeResult{
  // 公告id
  String id;
  // 公告标题
  String title;
  // 公告内容
  int? publishStatus;
  // 创建时间
  int type;
  // 发布人
  String publisherName;
  // 创建时间
  String level;
  // 发布时间
  String publishTime;
  // 是否已读
  int isRead;
  // 目标类型
  int? targetType;
  // 创建时间
  String? createTime;
  // 撤销时间
  String? revokeTime;

  NoticeResult({
    required this.id,
    required this.title,
    required this.publishStatus,
    required this.type,
    required this.publisherName,
    required this.level,
    required this.publishTime,
    required this.isRead,
    required this.targetType,
    required this.createTime,
    required this.revokeTime,
  });

  factory NoticeResult.fromJson(Map<String, dynamic> json) {
    return NoticeResult(
      id: json['id'],
      title: json['title'],
      publishStatus: json['publishStatus'],
      type: json['type'],
      publisherName: json['publisherName'],
      level: json['level'],
      publishTime: json['publishTime'],
      isRead: json['isRead'],
      targetType: json['targetType'],
      createTime: json['createTime'],
      revokeTime: json['revokeTime'],
    );
  }
}