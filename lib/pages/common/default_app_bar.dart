import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

AppBar defaultAppBar(){
  return AppBar(
    // actionsPadding: EdgeInsets.all(8),
    leading: Builder(
      builder: (BuildContext context){
        return GestureDetector(
          onTap: () {
            // 打开侧边抽屉栏
            Scaffold.of(context).openDrawer();
          },
          child: Icon(
            MingCuteIcons.mgc_menu_line,
          ),
        );
      },
    ),
    actions: [
      Builder(
        builder: (context) {
          return IconButton(
            onPressed: (){
              context.push('/notice');
            },
            icon: Badge(
              child: Icon(MingCuteIcons.mgc_bell_ringing_line),
            ),
          );
        },
      )
    ],
  );
}