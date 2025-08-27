// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_text.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class TopicText extends StatelessWidget {
  const TopicText({
    Key? key,
    required this.text,
    this.defaultStyle = const TextStyle(color: Colors.black),
    this.topicStyle = const TextStyle(color: Colors.blue),
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final String text;

  final TextStyle defaultStyle;

  final TextStyle topicStyle;

  final TextAlign textAlign;

  @override
  Widget build(BuildContext _context) => topicText(
    _context,
    text: text,
    defaultStyle: defaultStyle,
    topicStyle: topicStyle,
    textAlign: textAlign,
  );
}
