import 'package:my_social/model/common/base_result.dart';

class PageResponse<T extends BaseResult> { 
  int pages;
  int current;
  int size;
  int total;
  List<T> list;

  PageResponse({
    this.pages = 0,
    this.current = 0,
    this.size = 0,
    this.total = 0,
    this.list = const [],
  });

  factory PageResponse.fromJson(Map<String, dynamic> json, Function fromJson) => PageResponse(
    pages: json["data"]["pages"],
    current: json["data"]["current"],
    size: json["data"]["size"],
    total: json["data"]["total"],
    list: json["data"]["records"] == null ? [] : List<T>.from(json["data"]["records"].map((x) => fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pages": pages,
    "current": current,
    "size": size,
    "total": total,
    "data": list == null ? [] : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class PageRequest { 
  int pageNum;
  int pageSize;

  PageRequest({
    this.pageNum = 1,
    this.pageSize = 10
  });

  Map<String,dynamic> toJson() {
    return {
      "pageNum": pageNum,
      "pageSize": pageSize
    };
  }
}