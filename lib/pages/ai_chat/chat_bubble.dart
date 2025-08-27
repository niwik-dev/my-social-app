import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'chat_bubble.g.dart';


@swidget
Widget chatBubble(
  BuildContext context,
  {
    required String text,
    bool isUser = false,
  }
){
  
  BorderRadiusGeometry getBorderRadius(bool isUser){
    if(isUser){ 
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    } else{ 
      return const BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
  }

  Widget buildBubble(String text, bool isUser){
    return Wrap(
      alignment: isUser?WrapAlignment.end:WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light?
               isUser?Colors.black87:Colors.white:
               isUser?Colors.white:Theme.of(context).primaryColor,
            borderRadius: getBorderRadius(
              isUser
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8, left: 12, right: 12, bottom: 8
            ),
            child: text.isEmpty? 
              SizedBox(
                width: 16, height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ):
              GptMarkdown(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).brightness == Brightness.light?
                    isUser?Colors.white:Colors.black:
                    isUser?Colors.black:Colors.white
                ),
              ),
          ),
        )
      ],
    );
  }
  
  Widget buildFeedbackButtons(bool isUser){
    return Wrap(
      direction: Axis.horizontal,
      alignment: isUser ? WrapAlignment.end : WrapAlignment.start,
      children: [
        IconButton(
          onPressed: (){
            Clipboard.setData(
              ClipboardData(text: text)
            );
            // 短暂显示复制成功
          },
          icon: Icon(
            MingCuteIcons.mgc_copy_2_fill,
            size: 18,
            color: Theme.of(context).brightness == Brightness.dark? Colors.grey[100]: Colors.grey[150],
          ),
        ),
        if(!isUser)
        IconButton(
          onPressed: () => null,
          icon: Icon(
            MingCuteIcons.mgc_thumb_up_2_line,
            size: 18,
            color: Theme.of(context).brightness == Brightness.dark? Colors.grey[100]: Colors.grey[150],
          ),
        ),
        if(!isUser)
        IconButton(
          onPressed: () => null,
          icon: Icon(
            MingCuteIcons.mgc_thumb_down_2_line,
            size: 18,
            color: Theme.of(context).brightness == Brightness.dark? Colors.grey[100]: Colors.grey[150],
          )
        )
      ]
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildBubble(text, isUser),
        buildFeedbackButtons(isUser),
      ]
    ),
  );
}