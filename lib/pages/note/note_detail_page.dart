import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/note_api.dart';
import 'package:my_social/api/restful/user_api.dart';
import 'package:my_social/model/response/note_comment_result.dart';
import 'package:my_social/model/response/note_info_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/model/store/login_user.dart';
import 'package:my_social/pages/note/common/topic_text.dart';
import 'package:my_social/utils/format_utils.dart';

part 'note_detail_page.g.dart';

@hcwidget
Widget noteDetailPage(
    BuildContext context,
    WidgetRef ref,
    GoRouterState state
){ 
  String? noteId = state.pathParameters['noteId'];
  
  var noteComments = useState<List<NoteCommentResult>>(
    []
  );
  var commentPageNum = useState<int>(1);
  final commentPageSize = 10;
  var scrollController = useScrollController();

  var note = useState<NoteInfoResult>(
    NoteInfoResult.empty()
  );
  var loginUser = useState<LoginUser>(
    LoginUser()
  );

  NoteApi noteApi = NoteApi();
  UserApi userApi = UserApi();

  useEffect(() {
    if(noteId == null) {
      // TODO: 错误处理
    }

    // 获取笔记信息
    noteApi.getNoteInfoById(ref,noteId!).then(
      (result) {
        if(result == null) {
          // TODO: 错误处理
        }
        note.value = result!;
      }
    );

    // 获取评论列表
    noteApi.getNoteCommentList(
      ref, noteId: noteId, pageNum: 1, pageSize: commentPageSize
    )
    .then(
      (result) {
        if(result == null) {
          // TODO: 错误处理
        }
        noteComments.value = result;
      }
    );

    // 获取当前用户信息
    userApi.getCurrnentUser(ref).then(
      (result) {
        if(result == null) {
          // TODO: 错误处理
        }
        loginUser.value = result!;
      }
    );

    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        noteApi.getNoteCommentList(
          ref, noteId: noteId, pageNum: commentPageNum.value, pageSize: commentPageSize
        )
        .then(
          (result) {
            if(result == null) {
              // TODO: 错误处理
            }
            noteComments.value.addAll(result);
            commentPageNum.value++;
          }
        );
      }
    });

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
    body: Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 400,
                child: Swiper(
                  autoplay: true,
                  itemCount: note.value.imagesList.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      note.value.imagesList[index],
                      fit: BoxFit.scaleDown,
                      width: MediaQuery.of(context).size.width,
                      errorBuilder: (context, error, stackTrace){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16, right: 16, top: 16
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.value.title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light?
                         Colors.black:Colors.white,
                      ),
                    ),
                    TopicText(
                      text:note.value.descr,
                      defaultStyle: TextStyle(
                        fontSize: 14,
                        height: 1.75,
                        color: Theme.of(context).brightness == Brightness.light?
                         Colors.black:Colors.white,
                      ),
                      topicStyle: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.light?
                         Colors.blue[900]:Colors.blue[400],
                        height: 1.75
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 16, bottom: 8
                      ),
                      child: Divider(
                        height: 2,
                        color: Colors.black12,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('共 ${note.value.commentsCount} 条评论'),
                        Gap(2),
                        Icon(
                          MingCuteIcons.mgc_down_line
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if(loginUser.value.avatarUrl != null)
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            loginUser.value.avatarUrl!
                          ),
                        ),
                        Gap(8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              isDense: true,
                              hint: Text('爱评论的人运气都不太差'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none
                              ),
                              filled: true,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ),
            ),
            if(noteComments.value.isNotEmpty)
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index){
                    final comment = noteComments.value[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          comment.userAvatar
                        ),
                      ),
                      title: Text(
                        comment.userName
                      ),
                      subtitle: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: comment.content,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                                    fontSize: 14
                                  )
                                ),
                                TextSpan(
                                  text: ' ${
                                    ModernStyleFormatUtils.dateFormatRedNote(
                                      FormatUtils.parseTimestamp(comment.time)
                                    )
                                  } ',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light ?Colors.black45 : Colors.white54,
                                    fontSize: 12
                                  )
                                ),
                                TextSpan(
                                  text: ' ${comment.ipLocation} ',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white54,
                                    fontSize: 12
                                  )
                                )
                              ]
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              ' 回复 ',
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.light? Colors.black87 : Colors.white70,
                                fontSize: 12
                              )
                            ),
                            onTap: (){},
                          )
                        ],
                      ),
                      trailing: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            MingCuteIcons.mgc_thumb_up_2_line
                          ),
                          Text(
                            '${noteComments.value[index].likeCount}'
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: noteComments.value.length
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 36,
                child: Center(
                  child: Text('到底了'),
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 64,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(
              horizontal: 16
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 32,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          MingCuteIcons.mgc_edit_3_line,
                          size: 14,
                        ),
                        hintText: '说点什么...',
                        hintStyle: TextStyle(
                          fontSize: 12
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Gap(12),
                Icon(
                  MingCuteIcons.mgc_heart_line
                ),
                Gap(8),
                Text('${note.value.likedCount}'),
                Gap(8),
                Icon(
                  MingCuteIcons.mgc_star_line
                ),
                Gap(8),
                Text('${note.value.collectedCount}'),
                Gap(8),
                Icon(
                  MingCuteIcons.mgc_chat_2_line
                ),
                Gap(8),
                Text('${note.value.commentsCount}'),
              ],
            ),
          ),
        )
      ],
    )
  );
}