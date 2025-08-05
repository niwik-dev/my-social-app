class BaseResult {

  BaseResult();

  Map<String, dynamic> toJson() => {};

  factory BaseResult.fromJson(Map<String, dynamic> json){
    return BaseResult();
  }
}