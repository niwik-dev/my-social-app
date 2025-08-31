import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/short_video_api.dart';
import 'package:my_social/model/response/short_video_comment_result.dart';
import 'package:my_social/model/response/short_video_info_result.dart';
import 'package:my_social/utils/format_utils.dart';

part 'comment_section.g.dart';

@hcwidget
Widget commentSection(WidgetRef ref,{
  required ShortVideoInfoResult videoInfo,
  required VoidCallback onCloseComment
}){

  var commentPageNum = useState<int>(0);
  final commentPageSize = 20;
  var commentList = useState<List<ShortVideoCommentResult>>([]);
  var scrollController = useScrollController();

  ShortVideoApi shortVideoApi = ShortVideoApi();
  
  useEffect((){
    scrollController.addListener((){
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
        shortVideoApi.getShortVideoComments(
          ref,
          videoId: videoInfo.videoId,
          pageNum: commentPageNum.value,
          pageSize: commentPageSize,
        ).then(
          (result) {
            ++commentPageNum.value;
            if(result != null && result.isNotEmpty){
              commentList.value.addAll(result);
            }
          }
        );
      }
    });
    return (){};
  },[]);

  useEffect((){
    // 当videoInfo发生变化时，自动重新获取评论
    shortVideoApi.getShortVideoComments(
      ref,
      videoId: videoInfo.videoId,
      pageNum: commentPageNum.value,
      pageSize: commentPageSize,
    ).then(
      (result) {
        if(result!=null){
          commentList.value = result;
          ++commentPageNum.value;
        }
      }
    );
    return (){};
  },[videoInfo]);

  return CustomScrollView(
    controller: scrollController,
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
          ),
          width: 16,
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    child: Icon(
                      MingCuteIcons.mgc_close_line,
                      size: 16,
                    ),
                    onTap: ()=> onCloseComment()
                  )
                ],
              ),
              SizedBox(
                height: 24,
                child: Center(
                  child: Text(
                    '${FormatUtils.formatNumberCN(videoInfo.commentCount)}条评论',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        sliver: SliverList.builder(
          itemCount: commentList.value.length,
          itemBuilder: (context, index) {
            final comment = commentList.value[index];
            return ListTile(
              dense: true,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  comment.userAvatar
                ),
              ),
              title: Text(comment.userName),
              subtitle: Wrap(
                children: [
                  Text(comment.content),
                  Row(
                    children: [
                      Text(
                        '${ModernStyleFormatUtils.dateFormatRedNote(
                          FormatUtils.parseTimestamp(comment.time)
                        )} · ${comment.ipLocation}'
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Icon(
                          MingCuteIcons.mgc_heart_line,
                          size: 12,
                        ),
                        onTap: (){},
                      ),
                      Gap(4),
                      Text(
                        FormatUtils.formatNumber(
                          comment.diggCount
                        ),
                        style: TextStyle(
                          fontSize: 12
                        )
                      ),
                      Gap(8),
                      GestureDetector(
                        child: Icon(
                          MingCuteIcons.mgc_heart_crack_line,
                          size: 12,
                        ),
                        onTap: (){},
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      )
    ],
  );
}