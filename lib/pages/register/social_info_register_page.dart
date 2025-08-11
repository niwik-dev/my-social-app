import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/file_api.dart';
import 'package:my_social/api/restful/user_api.dart';
import 'package:my_social/model/request/user_register_body.dart';
import 'package:my_social/model/common/data_result.dart';
import 'package:my_social/model/response/upload_file_result.dart';
import 'package:my_social/utils/random_utils.dart';

part 'social_info_register_page.g.dart';

@hcwidget
Widget socialInfoRegisterPage(BuildContext context,WidgetRef ref,GoRouterState state){
  final Image defaultMaleAvatar = Image.asset(
    'assets/images/default-male-avatar.png',
  );
  final File defaultMaleFile = File(
    'assets/images/default-male-avatar.png',
  );

  final Image defaultFemaleAvatar = Image.asset(
    'assets/images/default-female-avatar.png',
  );
  final File defaultFemaleAvatarFile = File(
    'assets/images/default-female-avatar.png',
  );

  UserBody registerBody = state.extra as UserBody;
  var nickname = useState<String>("");
  var nicknameController = useTextEditingController();
  var gender = useState<int>(1);

  var isImageUpload = useState<bool>(false);
  var fileUpload = useState<File>(defaultMaleFile);
  var previewAvatar = useState<Image>(defaultMaleAvatar);

  var mobile = useState<String>("");

  UserApi userApi = UserApi();
  FileApi fileApi = FileApi();

  useEffect((){
    registerBody.nickname = nickname.value;
    registerBody.gender = gender.value;
    registerBody.mobile = mobile.value;
    return (){};
  },[nickname,gender,mobile]);

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
              '补充社交信息',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '让大家更好认识你',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 32),
            Align(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 96,
                      height: 96,
                      child: previewAvatar.value,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextButton.icon(
                    icon: Icon(MingCuteIcons.mgc_upload_line),
                    label: Text('上传头像'),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );
                      if (result != null) {
                        isImageUpload.value = true;
                        fileUpload.value = File(result.files.single.path!);
                        previewAvatar.value = Image.file(
                          fileUpload.value
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            Text('你的性别是'),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: gender.value == 1 ? Colors.blueAccent: null
                    ),
                    icon: Icon(MingCuteIcons.mgc_male_line),
                    label: Text('男'),
                    onPressed: () {
                      gender.value = 1;
                      if(!isImageUpload.value){
                        fileUpload.value = defaultMaleFile;
                        previewAvatar.value = defaultMaleAvatar;
                      }
                    },
                  ),
                ),
                VerticalDivider(
                  width: 4,
                  color: Colors.black26,
                ),
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: gender.value == 2 ? Colors.redAccent: null
                    ),
                    icon: Icon(MingCuteIcons.mgc_female_line),
                    label: Text('女'),
                    onPressed: () {
                      gender.value = 2;
                      if(!isImageUpload.value){
                        fileUpload.value = defaultFemaleAvatarFile;
                        previewAvatar.value = defaultFemaleAvatar;
                      }
                    },
                  ),
                ),
                VerticalDivider(
                  width: 4,
                ),
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: gender.value == 3 ? Colors.orangeAccent : null,
                    ),
                    icon: Icon(MingCuteIcons.mgc_lock_line),
                    label: Text('保密'),
                    onPressed: () {
                      gender.value = 3;
                      if(!isImageUpload.value){
                        fileUpload.value = defaultMaleFile;
                        previewAvatar.value = defaultMaleAvatar;
                      }
                    },
                  )
                )
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: nicknameController,
              decoration: InputDecoration(
                hintText: '昵称',
                prefixIcon: Icon(MingCuteIcons.mgc_user_2_line),
                suffixIcon: IconButton(
                  icon: Icon(MingCuteIcons.mgc_random_line),
                  onPressed: (){
                    // 随机生成昵称
                    nicknameController.text = RandomUtils.buildRandomNickName();
                    nickname.value = nicknameController.text;
                  },
                )
              ),
              onChanged: (value) {
                nickname.value = value;
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: '手机号',
                prefixIcon: Icon(MingCuteIcons.mgc_phone_line),
              ),
              onChanged: (value){
                mobile.value = value;
              },
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: Icon(MingCuteIcons.mgc_arrow_right_line),
                label: Text('完成注册'),
                onPressed: () async {
                  DataResult<UploadFileResult> fileResult = await fileApi.uploadFile(ref, fileUpload.value);
                  if(!fileResult.success){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(fileResult.message),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                  registerBody.nickname = nickname.value;
                  registerBody.gender = gender.value;
                  registerBody.mobile = mobile.value;
                  registerBody.avatar = fileResult.data!.url;
                  
                  DataResult<bool> registerResult = await userApi.saveUser(ref, registerBody);
                  if(!registerResult.success){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(registerResult.message),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("注册成功!"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    context.push('/account-login');
                  }
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}