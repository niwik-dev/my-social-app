import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:my_social/pages/overview/drawer_route.dart';

part 'route_delegate.g.dart';

@swidget
Widget drawerListRouteDelegate(
  BuildContext context, IDrawerListItem item
){
  if(item is DrawerRouteListItem){
    return ListTile(
      title: Text(item.title),
      leading: item.icon,
      onTap: () {
        if(item.path != null){
          context.push(item.path!);
        }
      },
    );
  }else if(item is DrawerRouteListGroup){
    var items = item.items;

    List<Widget> mapItemsToWidget(List<DrawerRouteListItem> items){
      List<Widget> list = [];
      for(int index=0;index<items.length;index++){
        DrawerRouteListItem item = items[index];

        ShapeBorder shapeBorder;
        if(index == 0){
          shapeBorder = RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            )
          );
        }else if(index == items.length-1){
          shapeBorder = RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            )
          );
        }else{
          shapeBorder = RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
          );
        }

        list.add(ListTile(
          title: Text(item.title),
          shape: shapeBorder,
          leading: item.icon,
          onTap: () {
            if(item.path != null){
              context.push(item.path!);
            }
          },
        ));
      }
      return list;
    }

    return Column(
      children: mapItemsToWidget(items)
    );
  }else{
    throw Exception('Invalid drawer route item');
  }
}

@swidget
Widget drawerActionRouteDelegate(
  BuildContext context, IDrawerActionItem item
){
  if(item is DrawerRouteActionItem){
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          icon: item.icon,
          onPressed: item.onTap,
        ),
        Text(item.title),
      ],
    );
  }else{
    throw Exception('Invalid drawer route item');
  }
}