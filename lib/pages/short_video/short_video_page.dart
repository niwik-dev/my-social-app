import 'dart:math';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/short_video_api.dart';
import 'package:my_social/model/common/page_response.dart';
import 'package:my_social/model/response/short_video_info_result.dart';
import 'package:my_social/pages/short_video/bottom_bar.dart';
import 'package:my_social/pages/short_video/comment_section.dart';
import 'package:my_social/pages/short_video/side_bar.dart';

import 'package:my_social/store/short_video/short_video_store.dart';


part 'short_video_page.g.dart';

AppBar shortVideoPageAppBar(){ 
  return AppBar(
    backgroundColor: Colors.black,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            MingCuteIcons.mgc_menu_line,
            color: Colors.white,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: '打开左侧抽屉栏',
        );
      },
    ),
  );
}

@hcwidget
Widget shortVideoPageBody(BuildContext context,WidgetRef ref){
  ShortVideoApi shortVideoApi = ShortVideoApi();
  var shortVideoStore = ref.watch(shortVideoStoreProvider);
  var shortVideoNotifier = ref.watch(shortVideoStoreProvider.notifier);

  var commentSectionHeight = useState<double>(0.0);
  var isCommentSectionOpen = useState<bool>(false);

  // 获取最大评论框高度
  double commentSectionMaxHeight() => MediaQuery.of(context).size.height*0.6;
  // 获取评论框最小可展开高度
  double commentSectionMinExpandbleHeight() => MediaQuery.of(context).size.height*0.4;

  var player = useMemoized(()=> Player());
  var playProgress = useState<Duration>(
    Duration(milliseconds: 0)
  );

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

    player.stream.position.listen((event) {
      playProgress.value = player.state.position;
    });

    return (){
      player.dispose();
    };
  },[]);

  void openCommentSection(){
    commentSectionHeight.value = commentSectionMaxHeight();
    Future.delayed(Duration(milliseconds: 100), (){
      isCommentSectionOpen.value = true;
    });
  }

  void closeCommentSection(){ 
    commentSectionHeight.value = 0;
    Future.delayed(Duration(milliseconds: 100), (){
      isCommentSectionOpen.value = false;
    });
  }

  return Container(
    color: Colors.black,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: shortVideoStore.videoList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Video(
                    fill: Colors.black,
                    controller: videoController,
                    controls: (VideoState state){
                      return Stack(
                        children: [
                          // 覆盖播放器页面，用于控制快进，暂停等操作
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: (){
                                if(player.state.playing){
                                  player.pause();
                                }else{
                                  player.play();
                                }
                              },
                            )
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 32,
                              child: Center(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 3,
                                    thumbColor: Colors.white,
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 0,
                                      disabledThumbRadius: 0,
                                    ),
                                    activeTrackColor: Theme.of(context).primaryColor,
                                    inactiveTrackColor: Colors.grey,
                                    valueIndicatorColor: Colors.white,
                                  ),
                                  child: Builder(
                                    builder: (context){
                                      if (player.state.duration.inSeconds == 0) {
                                        return const SizedBox.shrink();
                                      }

                                      return Slider(
                                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                                        thumbColor: Colors.white,
                                        min: 0, max: 1,
                                        value: playProgress.value.inSeconds / player.state.duration.inSeconds,
                                        onChanged: (value){
                                          Future.delayed(const Duration(milliseconds: 500), () {
                                            player.seek(
                                              Duration(
                                                seconds: (player.state.duration.inSeconds * value).toInt()
                                              )
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                                
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  
                  if(!isCommentSectionOpen.value)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ShortVideoSideBar(
                      videoInfo: shortVideoNotifier.getCurrentVideo(),
                      onOpenComment: (){
                        openCommentSection();
                      },
                    ),
                  ),

                  if(!isCommentSectionOpen.value)
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
          ),
        ),

        TapRegion(
          onTapOutside: (event){
            closeCommentSection();
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: double.infinity,
            height: commentSectionHeight.value,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: const Offset(0, -2),
                  blurRadius: 2,
                )
              ]
            ),
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                final newHeight = commentSectionHeight.value - details.delta.dy;
                if (newHeight >= 0 && newHeight <= commentSectionMaxHeight()) {
                  commentSectionHeight.value = newHeight;
                }
              },
              onVerticalDragEnd: (details) {
                if(commentSectionHeight.value < commentSectionMinExpandbleHeight()){
                  commentSectionHeight.value = 0;
                  isCommentSectionOpen.value = false;
                }else{
                  commentSectionHeight.value = commentSectionMaxHeight();
                  isCommentSectionOpen.value = true;
                }
              },
              child: Builder(
                builder: (context){
                  final videoInfo = shortVideoNotifier.getCurrentVideo();
                  if(videoInfo==null){
                    return SizedBox.shrink();
                  }
                  return CommentSection(
                    videoInfo:videoInfo,
                    onCloseComment: () => closeCommentSection(),
                  );
                },
              ),
            ),
          ),
        )
      ],
    ),
  );
}