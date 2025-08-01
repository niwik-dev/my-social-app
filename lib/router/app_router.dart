import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/pages/common/default_app_bar.dart';
import 'package:my_social/pages/home/home_page.dart';
import 'package:my_social/pages/overview/overview_page.dart';
import 'package:my_social/pages/index/index_page.dart';
import 'package:my_social/pages/login/login_page.dart';
import 'package:my_social/pages/overview/tab_route.dart';
import 'package:my_social/store/login/login_store.dart';

class AppRouterHolder{
  // 单例模式
  static final AppRouterHolder _instance = AppRouterHolder._internal();
  factory AppRouterHolder() => _instance;
  AppRouterHolder._internal();

  bool _init = false;
  late GoRouter _router;
  ProviderContainer container = ProviderContainer();

  GoRouter getRouter(){
    if(!_init){
      _router = GoRouter(
        initialLocation: '/',
        routes: [
          // App首页
          GoRoute(
            path: '/',
            builder: (context, state) => IndexPage(),
          ),

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
                    body: homePageBody(context)
                  ),
                  TabRouteItem(
                    tabName: '热门',
                    icon: Icon(MingCuteIcons.mgc_video_line),
                    activeIcon: Icon(MingCuteIcons.mgc_video_fill),
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
            ),
          ),
        ],
      );
      _init = true;
    }
    return _router;
  }
}