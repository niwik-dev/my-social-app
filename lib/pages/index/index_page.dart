import 'dart:io';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/components/logo/app_logo.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/hooks/use_mounted.dart';
import 'package:my_social/model/store/login_user.dart';
import 'package:my_social/store/login/login_store.dart';
import 'package:my_social/theme/app_theme.dart';

part 'index_page.g.dart';


@hcwidget
Widget indexPage(BuildContext context,WidgetRef ref, GoRouterState state){
   
    // 获取登录用户信息
  useMouted((){
    var loginUserStoreNotifier = ref.watch(loginUserStoreProvider.notifier);
    loginUserStoreNotifier.loadFromPerfs()
    .then((LoginUser? loginUser) {
      if(loginUser!=null && loginUser.isLoggedIn && loginUser.accessToken != null){
        context.go('/home');
      }
    });
  });

  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    useMouted(() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: const Text('检测到当前为PC平台，正在以兼容模式运行'),
            actions: <Widget>[
              TextButton(
                child: const Text('我已知晓'),
                onPressed: () {
                  context.pop();
                }
              )
            ]
          );
        }
      );
    });
  }

  var confirmPermit = useState<bool>(false);

  return Theme(
    data: AppThemeHolder().getLightTheme(),
    child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 173, 220, 208),
              Color.fromARGB(255, 239, 249, 246),
              Colors.white,
              Color.fromARGB(255, 239, 249, 246),
              Color.fromARGB(255, 173, 220, 208),
            ],
            stops: [0,0.15,0.5,0.85,1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        padding: EdgeInsets.only(
          top: 120,
          bottom: 80,
          left: 16,
          right: 16
        ),
        child: Column(
          children: [
            AppLogo(),
            SizedBox(height: 4),
            Text(
              '分享你的生活，记录点滴',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),
              
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                child: Wrap(
                  spacing: 8,
                  children: [
                    Icon(MingCuteIcons.mgc_user_2_fill),
                    Text(
                      '账户登录'
                    )
                  ],
                ),
                onPressed: (){
                  if(!confirmPermit.value){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('提示'),
                        content: Text('请先确认已同意软件使用协议'),
                        actions: [
                          TextButton(
                            child: Text('确认'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          )
                        ]
                      )
                    );
                    return;
                  }
                  context.push('/account-login');
                },
              ),
            ),

            SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: Wrap(
                  spacing: 8,
                  children: [
                    Icon(MingCuteIcons.mgc_phone_fill),
                    Text('手机号登录')
                  ],
                ),
                onPressed: () {
                  if(!confirmPermit.value){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('提示'),
                        content: Text('请先确认已同意软件使用协议'),
                        actions: [
                          TextButton(
                            child: Text('确认'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          )
                        ]
                      )
                    );
                    return;
                  }
                  context.push('/sms-login');
                },
              ),
            ),

            SizedBox(
              height: 24,
            ),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Checkbox.adaptive(
                  value: confirmPermit.value,
                  onChanged: (value) {
                    confirmPermit.value = value!;
                  },
                ),
                Text(
                  '我已阅读并同意 ',
                  style: TextStyle(
                    fontSize: 14
                  ),
                ),
                
                GestureDetector(
                  child: Text(
                    '《用户协议》',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87
                    ),
                  ),
                  onTap: () {
                  
                  },
                ),
                GestureDetector(
                  child: Text(
                    '《隐私政策》',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87
                    ),
                  ),
                  onTap: () {
                  
                  },
                ),

              ],
            )
          ],
        )
      ),
    ),
  );
}