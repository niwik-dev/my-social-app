import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

/// 聊天历史界面的固定首部栏
class ChatHistoryHeaderBarDelegate extends SliverPersistentHeaderDelegate{
  final double fixedHeight = 50;

  late String title;

  ChatHistoryHeaderBarDelegate({required this.title});
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light?Colors.white:Colors.black,
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          const Icon(
            MingCuteIcons.mgc_chat_1_line,
            size: 18,
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer()
        ],
      ),
    );
  }

  @override
  double get maxExtent => fixedHeight;

  @override
  double get minExtent => fixedHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
  
}