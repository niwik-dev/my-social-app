import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'empty.g.dart';

@swidget
Widget empty(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 16,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.grey.shade800,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            width: 120,
            height: 120,
            'assets/images/empty-box.png'
          ),
        ),
        Text('这里什么都没有'),
      ],
    ),
  );
}