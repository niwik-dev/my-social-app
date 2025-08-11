import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/auth_api.dart';
import 'package:my_social/model/response/captch_result.dart';
import 'package:my_social/model/common/data_result.dart';

part 'account_login_page.g.dart';

@hcwidget
Widget accoutLoginPage(BuildContext context,WidgetRef ref){
  var username = useState<String>("");
  var password = useState<String>("");
  var captcha = useState<String>("");
  var captchaImage = useState<Image?>(null);
  var captchaKey = useState<String>("");
  var rememberPassword = useState<bool>(false);

  AuthApi authApi = AuthApi();

  useEffect((){
    authApi.fetchCaptcha(ref).then((CaptchaResult result) { 
      captchaImage.value = result.captchImage;
      captchaKey.value = result.captchaKey;
    });
    return () {};
  },[]);

  return Container(
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
              '账户登录',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '登录以获取更多',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                hintText: '用户名或者邮箱',
                prefixIcon: Icon(MingCuteIcons.mgc_user_2_line),
              ),
              onChanged: (value) {
                username.value = value;
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: '密码',
                prefixIcon: Icon(MingCuteIcons.mgc_lock_line),
              ),
              obscureText: true,
              onChanged: (value) {
                password.value = value;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(MingCuteIcons.mgc_key_2_line),
                      hintText: '验证码',
                    ),
                    onChanged: (value) {
                      captcha.value = value;
                    },
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  child: SizedBox(
                    height: 42,
                    width: 140,
                    child: captchaImage.value ?? Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  onTap: () async{
                    CaptchaResult result = await authApi.fetchCaptcha(ref);
                    Image image = result.captchImage;
                    captchaImage.value = image;
                    captchaKey.value = result.captchaKey;
                  },
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: rememberPassword.value,
                  onChanged: (bool? value) {
                    rememberPassword.value = value!;
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
                onPressed: () async {
                  DataResult result = await authApi.login(
                    ref,
                    username: username.value,
                    password: password.value,
                    captcha: captcha.value,
                    captchaKey: captchaKey.value,
                  );
                  
                  if(result.success){
                    context.go('/home');
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result.message),
                      )
                    );
                    
                    {
                      // 刷新验证码
                      CaptchaResult result = await authApi.fetchCaptcha(ref);
                      Image image = result.captchImage;
                      captchaImage.value = image;
                      captchaKey.value = result.captchaKey;
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                Text('没有账号？'),
                TextButton(
                  child: Text('注册账户'),
                  onPressed: () {
                    context.push('/account-register');
                  },
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}