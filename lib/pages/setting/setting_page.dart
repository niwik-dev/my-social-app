import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/model/store/login_user.dart';
import 'package:my_social/router/app_router.dart';
import 'package:my_social/service/pref_service.dart';
import 'package:my_social/store/login/login_store.dart';
import 'package:my_social/theme/app_theme.dart';

part 'setting_page.g.dart';

@cwidget
Widget settingPage(BuildContext context,WidgetRef ref){
  var themeHolder = AppThemeHolder();
  var globalTheme = themeHolder.getTheme();
  PrefService prefService = PrefService();
  var loginUserStoreNotifier = ref.read(loginUserStoreProvider.notifier);

  return Theme(
    data: globalTheme.copyWith(
      listTileTheme: globalTheme.listTileTheme.copyWith(
        titleTextStyle: globalTheme.listTileTheme.titleTextStyle?.copyWith(
          fontSize: 16
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          textStyle: TextStyle(
            fontSize: 16,
            fontFamily: themeHolder.globalFontFamily
          )
        )
      )
    ),
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MingCuteIcons.mgc_left_line),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text('设置'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_user_4_line),
                  title: Text('账号与安全'),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  onTap: () {
                    context.push('/account-security');
                  },
                ),
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_settings_2_line),
                  title: Text('通用设置'),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  onTap: () {
                    context.push('/notification');
                  },
                ),
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_notification_line),
                  title: Text('通知设置'),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  onTap: () {
                    context.push('/notification');
                  },
                ),
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_shield_line),
                  title: Text('隐私设置'),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  onTap: () {
                    context.push('/privacy');
                  },
                ),
                ListTile(
                  leading: Icon(MingCuteIcons.mgc_information_line),
                  title: Text('关于本站'),
                  trailing: Icon(MingCuteIcons.mgc_right_line),
                  onTap: () {
                    context.push('/about');
                  },
                ),
                SizedBox(height: 16),
                TextButton(
                  child: Text('切换账号'),
                  onPressed: () {
                    
                  },
                ),
                SizedBox(height: 8),
                TextButton(
                  child: Text('退出登录'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // 打开询问框
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('提示'),
                          content: Text('确定要退出登录吗？'),
                          actions: [
                            TextButton(
                              child: Text('确定'),
                              onPressed: () {
                                // 清空登录状态信息
                                prefService.clearLoginUser();
                                loginUserStoreNotifier.setLoginUser(
                                  LoginUser()
                                );
                                // 退出登录
                                context.pop();
                                // 跳转到登录页面
                                context.go('/');
                              },
                            ),
                            TextButton(
                              child: Text('取消'),
                              onPressed: () {
                                context.pop();
                              }
                            )
                          ]
                        );
                      }
                    );
                  },
                )
              ])
            )
          ]
        ),
      ),
    ),
  );
}