import 'package:dio/dio.dart';
import 'package:my_social/model/common/base_result.dart';

class DataResult<T> extends BaseResult{
  T? data;
  String message;
  bool success;
  DataResult({
    required this.data,
    required this.message,
    required this.success,
  });

  factory DataResult.fromResponse({
    required Response response,
    T? Function(Map<String,dynamic>?)? parse
  }) {
    parse ??= (x) => x as T?;
    return DataResult(
      data: parse(response.data?["data"]),
      message: response.data?["msg"],
      success: response.data?["code"] == '00000' && response.statusCode == 200,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "message": message,
      "success": success,
    };
  }
}