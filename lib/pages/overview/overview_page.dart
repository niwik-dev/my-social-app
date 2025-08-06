import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/components/empty/empty.dart';
import 'package:my_social/pages/overview/drawer_route.dart';
import 'package:my_social/pages/overview/route_delegate.dart';
import 'package:my_social/pages/overview/tab_route.dart';

part 'overview_page.g.dart';


@hwidget
Widget overviewPage(
  BuildContext context,
  {
    required TabRoute tabRoute,
    required DrawerRoute drawerRoute
  }
){
  var currentTabIndex = useState<int>(0);
  var tabRouteItem = tabRoute.items[currentTabIndex.value];

  return Scaffold(
    appBar: tabRouteItem.appBar ?? tabRoute.defaultAppBar,
    body: tabRouteItem.body ?? Center(
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

      // 主要是针对短视频页面，短视频页面需要暗色底栏
      selectedItemColor: tabRouteItem.dark == true ? Colors.white: null,
      unselectedItemColor: tabRouteItem.dark == true ? Colors.white54: null,
      backgroundColor: tabRouteItem.dark == true?Colors.black:null,

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
          horizontal: 8, vertical: 24
        ),
        child: Column(
          children: [
            ...drawerRoute.list.map((item) { 
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: DrawerListRouteDelegate(item),
              );
            }),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...drawerRoute.action.map((item){
                  return DrawerActionRouteDelegate(item);
                }),
              ],
            )
          ],
        ),
      ),
    ),
  );
}