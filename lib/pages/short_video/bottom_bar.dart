import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:my_social/model/response/short_video_info_result.dart';
import 'package:my_social/utils/format_utils.dart';

part 'bottom_bar.g.dart';

@swidget
Widget shortVideoBottomBar(
  BuildContext context,{required ShortVideoInfoResult? videoInfo}
){
  
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.75,
          child: Text(
            '${videoInfo?.caption}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            softWrap: true,
            maxLines: 3,
          ),
        ),
        SizedBox(height: 4),

        if(videoInfo?.caption != videoInfo?.description)
        SizedBox(
          width: MediaQuery.of(context).size.width*0.75,
          child: Text(
            '${videoInfo?.description}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(height: 8),

        if(videoInfo?.playCount != null)
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '${videoInfo?.playCount}次播放',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14
              ),
            ),
            SizedBox(width: 8),
            Text(
              '发布于${
                FormatUtils.formatDateTime(
                  FormatUtils.parseTimestamp(videoInfo!.createTime),
                  format: 'MM-dd HH:mm'
                )
              }',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14
              ),
            ),
          ],
        ),

      ],
    ),
  );
}