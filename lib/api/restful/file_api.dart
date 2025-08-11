import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/model/common/data_result.dart';
import 'package:my_social/model/response/upload_file_result.dart';
import 'package:my_social/utils/request_utils.dart';

class FileApi{
  // 单例模式
  static final FileApi _instance = FileApi._internal();
  factory FileApi() => _instance;
  FileApi._internal();

  Future<DataResult<UploadFileResult>> uploadFile(WidgetRef ref,File file) async {
    String url = '/api/v1/files';
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
    });
    var response = await AuthRequestUtils.post(ref, url, data);
    
    DataResult<UploadFileResult> result = DataResult.fromResponse(
      response: response, parse: (json){
        return UploadFileResult.fromJson(json);
      }
    );
    return result;
  }
}