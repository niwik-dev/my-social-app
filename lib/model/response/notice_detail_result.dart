class NoticeDetailResult {
  // 通知id
  String id;
  // 通知标题
  String title;
  // 通知内容
  String content;
  // 通知类型
  int type;
  // 发布人
  String publisherName;
  // 优先级(L-低 M-中 H-高)
  String level;
  // 发布状态(0-未发布 1已发布 2已撤回) 冗余字段，方便判断是否已经发布
  int publishStatus;
  // 发布时间
  String publishTime;

  NoticeDetailResult({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.publisherName,
    required this.level,
    required this.publishStatus,
    required this.publishTime,
  });

  factory NoticeDetailResult.fromJson(Map<String,dynamic> data) {
    data = data["data"];
    return NoticeDetailResult(
      id: data['id'],
      title: data['title'],
      content: data['content'],
      type: data['type'],
      publisherName: data['publisherName'],
      level: data['level'],
      publishStatus: data['publishStatus'],
      publishTime: data['publishTime'],
    );
  }
}