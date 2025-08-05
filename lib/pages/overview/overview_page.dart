import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/components/empty/empty.dart';
import 'package:my_social/pages/overview/tab_route.dart';

part 'overview_page.g.dart';

@hwidget
Widget overviewPage(
  BuildContext context,
  {
    required TabRoute tabRoute,
  }
){
  var currentTabIndex = useState<int>(0);

  return Scaffold(
    appBar: AppBar(
      actionsPadding: EdgeInsets.all(8),
      actions: [
        IconButton(
          onPressed: (){},
          icon: Badge(
            child: Icon(MingCuteIcons.mgc_bell_ringing_line),
          ),
        )
      ],
    ),
    body: tabRoute.items[currentTabIndex.value].body ?? Center(
      child: Empty(),
    ),
    bottomNavigationBar: BottomNavigationBar(
      // https://github.com/flutter/flutter/issues/13642
      // 超过3个item时，不指定type会渲染异常
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTabIndex.value,
      onTap: (int index) {
        currentTabIndex.value = index;
      },
      items: tabRoute.items.map((item) {
        return BottomNavigationBarItem(
          icon: item.icon,
          activeIcon: item.activeIcon,
          label: item.tabName,
        );
      }).toList(),
    ),
    drawer: Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8, vertical: 32
        ),
        child: Column(
          children: [
            ListTile(
              title: Text('AI助手'),
              leading: Icon(MingCuteIcons.mgc_chat_2_line),
              onTap: () {},
            ),
            Gap(8),
            ListTile(
              title: Text('我的评论'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)
                )
              ),
              leading: Icon(MingCuteIcons.mgc_comment_2_line),
              style: ListTileStyle.drawer,
              onTap: () {},
            ),
            ListTile(
              title: Text('浏览记录'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)
                )
              ),
              leading: Icon(MingCuteIcons.mgc_history_line),
              onTap: () {},
            ),
            Gap(8),
            ListTile(
              title: Text('社区公约'),
              leading: Icon(MingCuteIcons.mgc_leaf_2_line),
              onTap: () {},
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(MingCuteIcons.mgc_scan_line),
                      onPressed: () {},
                    ),
                    Text('扫一扫')
                  ],
                ),
                Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(MingCuteIcons.mgc_service_line),
                      onPressed: () {},
                    ),
                    Text('客服咨询')
                  ],
                ),
                Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(MingCuteIcons.mgc_settings_3_line),
                      onPressed: () {},
                    ),
                    Text('设置')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}