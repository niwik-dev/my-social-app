import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/model/store/login_user.dart';
import 'package:my_social/pages/ai_chat/ai_chat_page.dart';
import 'package:my_social/pages/common/default_app_bar.dart';
import 'package:my_social/pages/error/error_page.dart';
import 'package:my_social/pages/home/home_page.dart';
import 'package:my_social/pages/note/note_detail_page.dart';
import 'package:my_social/pages/overview/drawer_route.dart';
import 'package:my_social/pages/overview/overview_page.dart';
import 'package:my_social/pages/index/index_page.dart';
import 'package:my_social/pages/login/login_page.dart';
import 'package:my_social/pages/overview/tab_route.dart';
import 'package:my_social/pages/setting/setting_page.dart';
import 'package:my_social/pages/short_video/short_video_page.dart';
import 'package:my_social/store/login/login_store.dart';

class AppRouterHolder{
  // 单例模式
  static final AppRouterHolder _instance = AppRouterHolder._internal();
  factory AppRouterHolder() => _instance;
  AppRouterHolder._internal();

  bool _init = false;
  late GoRouter _router;

  GoRouter getRouter(){
    if(!_init){
      _router = GoRouter(
        initialLocation: '/',
        // 错误页面
        errorBuilder: (context, state) => ErrorPage(),

        routes: [
          // App首页
          GoRoute(
            path: '/',
            builder: (context, state) => IndexPage(state),
          ),

          // 账户登录
          GoRoute(
            path: '/account-login',
            builder: (context, state) => AccoutLoginPage(),
          ),
          // 短信登录
          GoRoute(
            path: '/sms-login',
            builder: (context, state) => PhoneLoginPage(),
          ),
          // 注册
          GoRoute(
            path: '/register',
            builder: (context, state) => Placeholder(),
          ),

          // 主页
          GoRoute(
            path: '/home',
            builder: (context, state) => OverviewPage(
              tabRoute: TabRoute(
                defaultAppBar: defaultAppBar(),
                items: [
                  TabRouteItem(
                    tabName: '首页',
                    icon: Icon(MingCuteIcons.mgc_home_1_line),
                    activeIcon: Icon(MingCuteIcons.mgc_home_1_fill),
                    body: HomePageBody()
                  ),
                  TabRouteItem(
                    tabName: '热门',
                    icon: Icon(MingCuteIcons.mgc_video_line),
                    activeIcon: Icon(MingCuteIcons.mgc_video_fill),
                    body: ShortVideoPageBody(),
                    appBar: shortVideoPageAppBar(),
                    dark: true
                  ),
                  TabRouteItem(
                    tabName: '消息',
                    icon: Icon(MingCuteIcons.mgc_message_1_line),
                    activeIcon: Icon(MingCuteIcons.mgc_message_2_fill),
                  ),
                  TabRouteItem(
                    tabName: '我的',
                    icon: Icon(MingCuteIcons.mgc_user_2_line),
                    activeIcon: Icon(MingCuteIcons.mgc_user_2_fill),
                  ),
                ],
              ),

              drawerRoute: DrawerRoute(
                list: [
                  DrawerRouteListItem(
                    title: 'AI助手',
                    icon: Icon(MingCuteIcons.mgc_chat_2_line),
                  ),
                  DrawerRouteListGroup(
                    items: [
                      DrawerRouteListItem(
                        title: '我的评论',
                        icon: Icon(MingCuteIcons.mgc_comment_2_line),
                        path: '/my-comment'
                      ),
                      DrawerRouteListItem(
                        title: '历史浏览',
                        icon: Icon(MingCuteIcons.mgc_history_2_line),
                        path: '/hist-view'
                      ),
                    ]
                  ),
                  DrawerRouteListItem(
                    title: '社区公约',
                    icon: Icon(MingCuteIcons.mgc_leaf_2_line),
                    path: '/comm-conv'
                  )
                ]
              ),
            ),
          ),

          // 笔记详情页
          GoRoute(
            path: '/note/:noteId',
            builder: (context, state) => NoteDetailPage(state),
          ),

          // AI助手页面
          GoRoute(
            path: '/ai-assistant',
            builder: (context, state) => AiChatPage(),
          ),

          // 设置页面
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingPage(),
          ),
        ],
      );
      _init = true;
    }
    return _router;
  }
}