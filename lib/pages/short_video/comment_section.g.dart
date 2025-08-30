// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_section.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class CommentSection extends HookConsumerWidget {
  const CommentSection({
    Key? key,
    required this.videoInfo,
    required this.onCloseComment,
  }) : super(key: key);

  final ShortVideoInfoResult videoInfo;

  final void Function() onCloseComment;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) => commentSection(
    _ref,
    videoInfo: videoInfo,
    onCloseComment: onCloseComment,
  );
}
