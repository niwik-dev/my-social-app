import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'chat_topic_box.g.dart';

@swidget
Widget chatTopicBox(BuildContext context,
  {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }
){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light?
        Colors.grey[200]: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 8
      ),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.light?
               Colors.black87: Colors.white,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.light?
               Colors.black87: Colors.white,
            ),
          )
        ],
      ),
    ),
  );
}