import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';


part 'message_page.g.dart';

@hwidget
Widget messagePageBody(BuildContext context){

  var tabController = useTabController(initialLength: 2);

  return  Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        leading: Icon(MingCuteIcons.mgc_user_add_2_line),
        title: Text('新朋友'),
        trailing: Icon(MingCuteIcons.mgc_right_line),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(MingCuteIcons.mgc_group_line),
        title: Text('群通知'),
        trailing: Icon(MingCuteIcons.mgc_right_line),
        onTap: () {},
      ),
      Gap(16),
      Container(
        color: Theme.of(context).listTileTheme.tileColor,
        child: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: '聊天'),
            Tab(text: '通讯录'),
          ],
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: tabController,
          children: [
            Center(
              child: Text('聊天'),
            ),
            Center(
              child: Text('通讯录'),
            ),
          ],
        ),
      ),

    ],
  );
}