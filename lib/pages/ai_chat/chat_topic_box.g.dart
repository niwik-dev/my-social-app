// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_topic_box.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ChatTopicBox extends StatelessWidget {
  const ChatTopicBox({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final String title;

  final String subtitle;

  final void Function() onTap;

  @override
  Widget build(BuildContext _context) => chatTopicBox(
        _context,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
      );
}
