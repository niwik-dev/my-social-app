import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

part 'ai_chat_page.g.dart';

@swidget
Widget aiChatPage(BuildContext context) { 
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(MingCuteIcons.mgc_left_line),
      ),
    ),
  );
}