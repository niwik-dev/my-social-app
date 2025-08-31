import 'package:my_social/model/common/page_response.dart';

class NoticePageBody extends PageRequest{
  // 公告标题
  String? title;
  // 公告内容
  int? publishStatus;
  // 发布时间
  List<String>? publishTime;
  // 发布人
  int? userId;
  // 是否已读
  int? isRead;

  NoticePageBody({
    this.title,
    this.publishStatus,
    this.publishTime,
    this.userId,
    this.isRead,
    super.pageNum,
    super.pageSize
  });
}