/*
 * tab切换页面路由
 */

import 'package:flutter/material.dart';

class TabRouteItem{
  String tabName;
  Widget icon;
  Widget activeIcon;
  Widget? body;
  AppBar? appBar;

  // 页面例如短视频需要底部栏为暗色
  bool? dark;

  TabRouteItem({
    required this.tabName,
    required this.icon,
    required this.activeIcon,
    this.body,
    this.appBar,
    this.dark
  });
}

class TabRoute{
  List<TabRouteItem> items = [];
  AppBar? defaultAppBar;

  TabRoute({
    required this.items,
    this.defaultAppBar,
  });
}