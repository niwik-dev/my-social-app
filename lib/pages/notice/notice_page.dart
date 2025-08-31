import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/notice_api.dart';
import 'package:my_social/model/request/notice_page_body.dart';
import 'package:my_social/model/response/notice_detail_result.dart';
import 'package:my_social/model/response/notice_result.dart';
import 'package:my_social/utils/format_utils.dart';

part 'notice_page.g.dart';

@hcwidget
Widget noticeDetailCard(WidgetRef ref,NoticeResult notice){
  var noticeDetail = useMemoized(
    () async {
      NoticeApi noticeApi = NoticeApi();
      return await noticeApi.getNoticeDetail(ref, notice.id);
    },
    [notice.id]
  );

  var noticeDetailSnap = useFuture(noticeDetail);

  return noticeDetailSnap.data == null ?
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircularProgressIndicator()
      ),
    ) :
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 8
      ),
      child: Wrap(
        children: [
          Html(
            data: noticeDetailSnap.data!.content,
            shrinkWrap: true,
            style: {
              "p": Style(
                fontSize: FontSize(16.0),
                margin: Margins.all(4),
              )
            },
          ),
        ]
      )
    );
}

@hcwidget
Widget noticePage(WidgetRef ref, BuildContext context) {
  var noticeList = useState<List<NoticeResult>>([]);

  useEffect(() {
    NoticeApi noticeApi = NoticeApi();
    noticeApi.getNoticePage(
      ref,NoticePageBody()
    ).then((response){
      noticeList.value = response.list;
    });
    return () {};
  });

  return Scaffold(
    appBar: AppBar(
      title: Text('公告'),
    ),
    body: Container(
      padding: EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: noticeList.value.length,
            itemBuilder: (context, index) {
              final notice = noticeList.value[index];
              return ExpansionTile(
                tilePadding: EdgeInsets.all(8),
                dense: true,
                leading: Icon(
                  MingCuteIcons.mgc_notification_line
                ),
                title: Text(notice.title),
                subtitle: Text(
                  '${notice.publisherName} ${ModernStyleFormatUtils.dateFormatRedNote(
                    DateTime.parse(notice.publishTime)
                  )}'
                ),
                trailing: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(
                      notice.isRead == 1 ?
                       MingCuteIcons.mgc_check_line : MingCuteIcons.mgc_clock_line,
                      size: 20,
                    ),
                    Text(
                      notice.isRead == 1 ?
                       '已读' : '未读'
                    )
                  ],
                ),
                children: [
                  NoticeDetailCard(notice)
                ],
              );
            },
          )
        ],
      ),
    ),
  );
}