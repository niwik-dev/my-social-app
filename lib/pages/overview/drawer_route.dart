import 'package:flutter/material.dart';

class IDrawerListItem{}

class DrawerRouteListItem extends IDrawerListItem{
  String title;
  Widget icon;
  String? path;

  DrawerRouteListItem({
    required this.title,
    required this.icon,
    this.path
  });
}

class DrawerRouteListGroup extends IDrawerListItem{
  List<DrawerRouteListItem> items;

  DrawerRouteListGroup({
    required this.items
  });
}

class IDrawerActionItem{}

class DrawerRouteActionItem extends IDrawerActionItem{
  String title;
  Widget icon;
  Function() onTap;

  DrawerRouteActionItem({
    required this.title,
    required this.icon,
    required this.onTap
  });
}

class DrawerRoute{ 
  List<IDrawerListItem> list = [];
  List<IDrawerActionItem> action = [];

  DrawerRoute({
    this.list = const [],
    this.action = const []
  });
}