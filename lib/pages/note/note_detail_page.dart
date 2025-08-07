import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/note_api.dart';
import 'package:my_social/model/response/note_info_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'note_detail_page.g.dart';

@hcwidget
Widget noteDetailPage(
    BuildContext context,
    WidgetRef ref,
    GoRouterState state
){ 
  String? noteId = state.pathParameters['noteId'];
  
  var note = useState<NoteInfoResult>(
    NoteInfoResult.empty()
  );
  NoteApi noteApi = NoteApi();

  useEffect(() {
    if(noteId == null) {
      // TODO: 错误处理
      context.pop();
    }

    noteApi.getNoteInfoById(ref,noteId!).then(
      (result) {
        if(result == null) {
          // TODO: 错误处理
        }
        note.value = result!;
      }
    );

    return () {};
  },[]);

  return Scaffold(
    appBar: AppBar(
      leading: GestureDetector(
        child: Icon(MingCuteIcons.mgc_left_line),
        onTap: () {
          context.pop();
        },
      ),
      titleSpacing: 0,
      leadingWidth: 45,
      title: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(note.value.userAvatar),
          ),
          Text(
            note.value.userName,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            // 分享
          },
        )
      ],
    ),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 400,
            child: Image.network(
              note.value.coverUrl,
              fit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.width,
              errorBuilder: (context, error, stackTrace){
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.value.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8),
                Text(
                  note.value.descr,
                  style: TextStyle(
                    fontSize: 14,
                    // 行距
                    height: 1.75,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    )
  );
}