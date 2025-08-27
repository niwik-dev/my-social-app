import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'topic_text.g.dart';

@swidget
Widget topicText(BuildContext context,{
  required String text,
  TextStyle defaultStyle = const TextStyle(color: Colors.black),
  TextStyle topicStyle = const TextStyle(color: Colors.blue),
  TextAlign textAlign = TextAlign.start
}){ 
  // 使用正则表达式匹配话题标签
  final RegExp topicRegex = RegExp(r'#(.*?)#');
  final List<TextSpan> textSpans = [];
  int currentIndex = 0;

  // 查找所有匹配的话题标签
  final Iterable<Match> matches = topicRegex.allMatches(text);

  for (final Match match in matches) {
    // 添加匹配前的普通文本
    if (match.start > currentIndex) {
      textSpans.add(
        TextSpan(
          text: text.substring(currentIndex, match.start),
          style: defaultStyle,
        ),
      );
    }

    // 去除 [话题]# 修饰字符
    final String topicText = text
    .substring(match.start, match.end)
    .replaceAll('[话题]#', '');
    textSpans.add(
      TextSpan(
        text: topicText, // 或者使用 topicText.substring(0, topicText.length - 1) 去掉末尾的#
        style: topicStyle,
      ),
    );
    currentIndex = match.end;
  }

  // 添加剩余的普通文本
  if (currentIndex < text.length) {
    textSpans.add(
      TextSpan(
        text: text.substring(currentIndex),
        style: defaultStyle,
      ),
    );
  }

  return RichText(
    textAlign: textAlign,
    text: TextSpan(
      children: textSpans,
    ),
  );
}