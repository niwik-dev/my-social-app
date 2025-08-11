import 'package:my_social/model/common/base_result.dart';

class UploadFileResult extends BaseResult{
  // 文件名
  String name;
  // 文件路径
  String url;

  UploadFileResult({
    required this.name,
    required this.url,
  });

  factory UploadFileResult.fromJson(Map<String, dynamic>? json) {
    return UploadFileResult(
      name: json?["name"] ?? "",
      url: json?["url"] ?? "",
    );
  }
}