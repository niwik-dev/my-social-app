import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/components/empty/empty.dart';

part 'error_page.g.dart';

@swidget
Widget errorPage(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(
          MingCuteIcons.mgc_left_line,
        ),
        onPressed: (){
          context.pop();
        }
      ),
      title: Text('找不到页面'),
    ),
    body: Center(
      child: Empty(),
    ),
  );
}