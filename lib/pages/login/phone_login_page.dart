import 'dart:async';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/auth_api.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'phone_login_page.g.dart';

@hcwidget
Widget phoneLoginPage(BuildContext context,WidgetRef ref){
  var phoneNumber = useState<String>('');
  var smsCodeCountDown = useState<int>(0);
  var canSendSmsCode = useState<bool>(true);

  AuthApi authApi = AuthApi();

  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 173, 220, 208),
          Color.fromARGB(255, 239, 249, 246),
          Colors.white,
        ],
        stops: [0,0.1,1.0],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: (){
            context.pop();
          },
        ),
      ),
      body: Container(
        padding:EdgeInsets.only(
          top: 8,
          left: 18,
          right: 18
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '手机号登录',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '如果未注册，将自动注册并登录',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 32),
            TextField(
              maxLength: 11,
              onChanged: (value) {
                phoneNumber.value = value;
              },
              decoration: InputDecoration(
                hintText: '手机号',
                prefixIcon: Icon(MingCuteIcons.mgc_phone_line),
                suffix: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Text(
                      canSendSmsCode.value ? '获取验证码' : '重新发送（${smsCodeCountDown.value}）',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      )
                    ),
                    onTap: () {
                      if(!canSendSmsCode.value){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('请稍后再重试'),
                          )
                        );
                        return;
                      }
                      
                      authApi.sendSmsCode(phoneNumber.value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('验证码发送成功'),
                        )
                      );

                      canSendSmsCode.value = false;
                      smsCodeCountDown.value = 60;
                      Timer.periodic(Duration(seconds: 1), (timer){
                        if(smsCodeCountDown.value > 0){
                          smsCodeCountDown.value--;
                        }else{
                          canSendSmsCode.value = true;
                          timer.cancel();
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: '验证码',
                prefixIcon: Icon(MingCuteIcons.mgc_mail_line),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {
                    
                  },
                ),
                Text('记住密码'),
                Spacer(),
                TextButton(
                  child: Text('忘记密码'),
                  onPressed: () {
                    context.push('/register');
                  },
                )
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                child: Text('登录'),
                onPressed: () {
                  context.push('/');
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}