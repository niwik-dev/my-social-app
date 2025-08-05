import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/api/restful/note_api.dart';
import 'package:my_social/model/common/page_response.dart';
import 'package:my_social/model/response/note_info_result.dart';

part 'home_page.g.dart';

@swidget
Widget noteCard({
  required NoteInfoResult note,
  Function()? onTap
}){
  return GestureDetector(
    onTap: onTap,
    child: Card(
      child: Wrap(
        children: [
          Image.network(
            note.coverUrl,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 4
            ),
            child: Text(
              note.title,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 4
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 8,
                  backgroundImage: NetworkImage(note.userAvatar),
                ),
                Gap(8),
                Text(
                  note.userName,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          )
        ]
      ),
    ),
  );
}

@hcwidget
Widget homePageBody(BuildContext context,WidgetRef ref){
  NoteApi noteApi = NoteApi();

  final int pageSize = 10;
  var total = useState(0);
  var pageNum = useState(1);
  var noteList = useState<List<NoteInfoResult>>([]);
  var isFetching = useState(false);
  var scrollController = useScrollController();

  useEffect((){
    noteApi.getNoteInfoPage(ref,PageRequest(
      pageNum: pageNum.value, pageSize: pageSize
    )).then((value) { 
      if(value != null){
        noteList.value = value.list;
        total.value = value.total;
      }
    });

    // 即将滑动到页面底部就刷新数据
    scrollController.addListener(() { 
      // 页面过半时，自动加载新内容
      if(!isFetching.value && scrollController.position.pixels*2 >= scrollController.position.maxScrollExtent){
        pageNum.value++;
        isFetching.value = true;
        noteApi.getNoteInfoPage(ref,PageRequest(
          pageNum: pageNum.value, pageSize: pageSize
        )).then((result) { 
          if(result != null){
            noteList.value.addAll(result.list);
            total.value = result.total;
          }
          isFetching.value = false;
        });
      }
    });
    return (){};
  },[]);

  return CustomScrollView(
    controller: scrollController,
    slivers: [
      SliverToBoxAdapter(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          children: [
            for (NoteInfoResult note in noteList.value)
            NoteCard(note: note, onTap: (){
              context.push('/note/${note.noteId}');
            }),
          ],
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 28.0,
          child: Center(
            child: Text(
              "已经到底了",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      )
    ],
  );
}