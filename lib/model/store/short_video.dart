import 'package:my_social/model/response/short_video_info_result.dart';

class ShortVideoList{
  List<ShortVideoInfoResult> videoList = [];
  int currentVideoIndex = 0;

  ShortVideoList({
    this.videoList = const [],
    this.currentVideoIndex = 0,
  });
}