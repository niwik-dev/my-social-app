import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/bing_api.dart';
import 'package:my_social/api/restful/user_api.dart';
import 'package:my_social/hooks/use_mounted.dart';
import 'package:my_social/model/store/login_user.dart';
import 'package:my_social/store/login/login_store.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/theme/app_theme.dart';

part 'person_page.g.dart';

class PersonPageHeaderDelegate extends SliverPersistentHeaderDelegate {
  String? imageUrl;
  LoginUser? loginUser;
  final double cardHeight = 120;

  PersonPageHeaderDelegate({
    required this.imageUrl,
    required this.loginUser,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        // 背景图片
        Container(
          margin: EdgeInsets.only(bottom: cardHeight/2),
          decoration: imageUrl != null?BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl!),
              fit: BoxFit.cover,
            ),
          ):null,
          foregroundDecoration:
          BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.transparent,
                Colors.black.withAlpha(200),
              ],
            ),
          )
        ),

        // 头部AppBar
        AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              MingCuteIcons.mgc_menu_line,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                MingCuteIcons.mgc_scan_line,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                MingCuteIcons.mgc_share_3_line,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: cardHeight,
            child: Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(
                horizontal: 16
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(loginUser!.avatarUrl!),
                      radius: 42,
                    ),
                    Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loginUser!.nickname!,
                          style: TextStyle(
                            fontSize: 20,
                          )
                        ),
                        Text(
                          '@${loginUser!.username}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF999999)
                          )
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        MingCuteIcons.mgc_right_line,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 150.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  } 
}

@swidget
Widget statistics(BuildContext context,{
  required IconData icon,
  required String label,
  required int value
}){
  return Wrap(
    direction: Axis.vertical,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 2.0,
    children: [
      Icon(
        icon,
        size: 32.0,
      ),
      Wrap(
        spacing: 8,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )
        ],
      )
    ],
  );
}

@hcwidget
Widget personPageBody(BuildContext context,WidgetRef ref){
  UserApi userApi = UserApi();
  BingApi bingApi = BingApi();
  var loginUser = useState<LoginUser?>(null);
  var imageUrl = useState<String?>(null);

  useEffect((){
    userApi.getCurrnentUser(ref).then((value) {
      loginUser.value = value;
    });
    bingApi.getBingImage().then((value) {
      imageUrl.value = value;
    });
  },[]);

  AppThemeHolder themeHolder = AppThemeHolder();
  ThemeData theme = themeHolder.getTheme();

  return Theme(
    data: themeHolder.getTheme().copyWith(
      listTileTheme: theme.listTileTheme.copyWith(
        titleTextStyle: theme.listTileTheme.titleTextStyle?.copyWith(
          fontSize: 16.0
        )
      ),
    ),
    child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: PersonPageHeaderDelegate(
              imageUrl: imageUrl.value,
              loginUser: loginUser.value,
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0
            ),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Statistics(
                        icon: MingCuteIcons.mgc_user_follow_2_line,
                        label: "粉丝",
                        value: 0,
                      ),
                      Statistics(
                        icon: MingCuteIcons.mgc_thumb_up_2_line,
                        label: "获赞",
                        value: 0,
                      ),
                      Statistics(
                        icon: MingCuteIcons.mgc_eye_line,
                        label: "访客",
                        value: 0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 16
            ),
            sliver: SliverList.list(
              children: [
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_photo_album_2_line),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  title: Text('相册'),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_camera_2_line),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  title: Text('动态'),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_star_line),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  title: Text('收藏'),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_folder_line),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  title: Text('文件'),
                  onTap: (){},
                ),
              ],
            )
          ),

          SliverPadding(
            padding: EdgeInsets.only(top: 50),
          )
        ],
      ),
    ),
  );
}