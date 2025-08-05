import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/model/response/short_video_info_result.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:my_social/utils/format_utils.dart';

part 'side_bar.g.dart';

@swidget
Widget networkVideoAuthorAvatar(BuildContext context, {required String avatarUrl}){ 
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: const Color.fromARGB(255, 255, 255, 255),
        width: 2,
      )
    ),
    child: CircleAvatar(
      backgroundImage: NetworkImage(
        avatarUrl
      ),
      radius: 16,
    ),
  );
}

@swidget
Widget defaultVideoAuthorAvatar(BuildContext context){ 
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      border: Border.all(
        color: const Color.fromARGB(255, 255, 255, 255),
        width: 2,
      )
    ),
    child: Icon(
      MingCuteIcons.mgc_user_1_line,
      size: 32,
    )
  );
}

@swidget Widget sideBarIconButton({
  required IconData icon,
  required String label,
  int? number,
  VoidCallback? onPressed
}){
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    direction: Axis.vertical,
    children: [
      IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        onPressed: onPressed,
      ),

      if(number == null)
      Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),

      if(number != null)
      Text(
        FormatUtils.formatNumber(number),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      )
    ],
  );
}


@swidget
Widget shortVideoSideBar(
  BuildContext context,
  {
    required ShortVideoInfoResult? videoInfo
  }
){
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Wrap(
      spacing: 4,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [

        videoInfo!=null?
        NetworkVideoAuthorAvatar(
          avatarUrl: videoInfo.authorThumbUrl,
        )
        :
        const DefaultVideoAuthorAvatar(),

        sideBarIconButton(
          icon: MingCuteIcons.mgc_comment_2_line,
          label: '评论',
          number: videoInfo?.commentCount,
          onPressed: (){},
        ),

        sideBarIconButton(
          icon: MingCuteIcons.mgc_thumb_up_2_line,
          label: '点赞',
          number: videoInfo?.diggCount,
          onPressed: (){},
        ),

        sideBarIconButton(
          icon: MingCuteIcons.mgc_star_line,
          label: '收藏',
          number: videoInfo?.collectCount,
          onPressed: (){},
        ),

        sideBarIconButton(
          icon: MingCuteIcons.mgc_share_2_line,
          label: '分享',
          number: videoInfo?.shareCount,
          onPressed: (){},
        ),
      ],
    ),
  );
}