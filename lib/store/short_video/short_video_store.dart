import 'package:my_social/model/response/short_video_info_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/store/short_video.dart';

part 'short_video_store.g.dart';

@riverpod
class ShortVideoStore extends _$ShortVideoStore{
  @override
  ShortVideoList build() {
    return ShortVideoList();
  }

  void addVideos(List<ShortVideoInfoResult> videoList){
    state = ShortVideoList(
      videoList: [...state.videoList, ...videoList],
      currentVideoIndex: state.currentVideoIndex,
    );
  }

  // 获取当前视频
  ShortVideoInfoResult? getCurrentVideo(){
    if(state.videoList.isEmpty){
      return null;
    }
    return state.videoList[state.currentVideoIndex];
  }

  // 获取上一个视频
  ShortVideoInfoResult getPrevVideo() {
    return state.videoList[state.currentVideoIndex - 1];
  }
  
  // 获取下一个视频
  ShortVideoInfoResult getNextVideo() {
    return state.videoList[state.currentVideoIndex + 1];
  }

  // 跳转到上一个视频
  ShortVideoInfoResult gotoPrevVideo(){
    state = ShortVideoList(
      videoList: state.videoList,
      currentVideoIndex: state.currentVideoIndex - 1,
    );
    return state.videoList[state.currentVideoIndex];
  }

  // 跳转到下一个视频
  ShortVideoInfoResult gotoNextVideo(){
    // 更新当前视频索引
    state = ShortVideoList(
      videoList: state.videoList,
      currentVideoIndex: state.currentVideoIndex + 1,
    );
    return state.videoList[state.currentVideoIndex];
  }

  // 跳转到指定视频
  Future<ShortVideoInfoResult?> gotoVideoAt(int index) async {
    if(index >= state.videoList.length){
      return null;
    }
    // 获取当前视频索引
    state = ShortVideoList(
      videoList: state.videoList,
      currentVideoIndex: index,
    );
    return state.videoList[state.currentVideoIndex];
  }

}