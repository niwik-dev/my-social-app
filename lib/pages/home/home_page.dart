import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'home_page.g.dart';

@hwidget
Widget homePageBody(BuildContext context){
  return StaggeredGrid.count(
    crossAxisCount: 2,
    children: [
      for (var i = 0; i < 10; i++)
      Card(
        child: Container(
          width: 100,
          height: Random().nextInt(100).toDouble()+150,
          color: Colors.red,
        ),
      )
    ],
  );
}