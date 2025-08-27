import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/model/request/user_register_body.dart';
import 'package:my_social/theme/app_theme.dart';

part 'account_register_page.g.dart';

@hcwidget
Widget accountRegisterPage(BuildContext context,WidgetRef ref){
  var username = useState<String>("");
  var password = useState<String>("");
  var repeatPassword = useState<String>("");
  UserBody registerBody = UserBody(
    username: username.value,
    password: password.value,
  );

  useEffect((){
    registerBody.username = username.value;
    registerBody.password = password.value;
    return (){};
  },[username,password]);

  return Theme(
    data: AppThemeHolder().getLightTheme(),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 193, 231, 222),
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
                '注册新账户',
                style: TextStyle(
                  fontSize: 32
                ),
              ),
              Text(
                '填写下方用户信息',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  hintText: '用户名',
                  prefixIcon: Icon(MingCuteIcons.mgc_user_2_line),
                ),
                onChanged: (value) {
                  username.value = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: '登录密码',
                  prefixIcon: Icon(MingCuteIcons.mgc_lock_line),
                ),
                obscureText: true,
                onChanged: (value) {
                  password.value = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '重复密码',
                  prefixIcon: Icon(MingCuteIcons.mgc_lock_line),
                ),
                obscureText: true,
                onChanged: (value) {
                  repeatPassword.value = value;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != password.value) {
                    return '密码不一致';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  child: Text('下一步'),
                  onPressed: () async {
                    context.push('/social-info-register',extra: registerBody);
                    return;
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  Text('注册过账户？'),
                  TextButton(
                    child: Text('立即登录'),
                    onPressed: () {
                      context.push('/account-login');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}