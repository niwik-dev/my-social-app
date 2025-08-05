import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/api/restful/short_video_api.dart';
import 'package:my_social/model/common/page_response.dart';
import 'package:my_social/model/response/short_video_info_result.dart';
import 'package:my_social/pages/short_video/bottom_bar.dart';
import 'package:my_social/pages/short_video/side_bar.dart';

import 'package:my_social/store/short_video/short_video_store.dart';


part 'short_video_page.g.dart';

@hcwidget
Widget shortVideoPageBody(BuildContext context,WidgetRef ref){
  ShortVideoApi shortVideoApi = ShortVideoApi();
  var shortVideoStore = ref.watch(shortVideoStoreProvider);
  var shortVideoNotifier = ref.watch(shortVideoStoreProvider.notifier);

  var player = useMemoized(()=> Player());
  VideoController videoController = useMemoized(
    ()=> VideoController(
      player,
      configuration: VideoControllerConfiguration()
    )
  );

  useEffect((){
    // 初始加载视频
    shortVideoApi.getShortVideoInfoPage(ref, PageRequest())
    .then((result) {
      if(result != null){
        shortVideoNotifier.addVideos(result.list);
        player.open(
          Media(
            shortVideoNotifier.getCurrentVideo()!.videoUrl
          )
        );
      }
    });

    // 监听视频播放进度，播放结束自动下一条
    player.stream.completed.listen((completed) {
      if(completed){
        shortVideoNotifier.gotoNextVideo();
        player.open(
          Media(
            shortVideoNotifier.getCurrentVideo()!.videoUrl
          )
        );
      }
    });

    return (){
      player.dispose();
    };
  },[]);

  return PageView.builder(
    scrollDirection: Axis.vertical,
    itemCount: shortVideoStore.videoList.length,
    itemBuilder: (context, index) {
      return Stack(
        children: [
          Video(
            controller: videoController,
            controls: (VideoState state){
              return SizedBox();
            },
          ),
          
          Align(
            alignment: Alignment.centerRight,
            child: ShortVideoSideBar(
              videoInfo: shortVideoNotifier.getCurrentVideo(),
            ),
          ),

          Positioned(
            bottom: 32,
            left: 16,
            child: ShortVideoBottomBar(
              videoInfo: shortVideoNotifier.getCurrentVideo(),
            )
          )

        ],
      );
    },
    onPageChanged: (int pageIndex) {
      // 切换到对应视频并且播放
      shortVideoNotifier.gotoVideoAt(
        pageIndex
      ).then(
        (ShortVideoInfoResult? videoInfo){
          if(videoInfo != null){
            player.open(
              Media(
                videoInfo.videoUrl
              )
            );
          }
        }
      );
    },
  );
}