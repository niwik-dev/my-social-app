import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'app_logo.g.dart';

@swidget
Widget appLogo(BuildContext context){ 
  return Wrap(
    children: [
      Text(
        '青柠',
        style: TextStyle(
          color: Color(0xFF5EC7AB),
          fontSize: 48,
          fontWeight: FontWeight.bold,
          letterSpacing: 2
        )
      ),
      Text(
        '圈子',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 2
        )
      )
    ]
  );
}