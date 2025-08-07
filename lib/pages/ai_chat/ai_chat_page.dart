import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

part 'ai_chat_page.g.dart';

@hwidget
Widget aiChatPage(BuildContext context) { 
  GlobalKey<ScaffoldState> scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());
  
  return Scaffold(
    key: scaffoldKey,
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8
          ),
          height: 0.5,
          color: Colors.black12,
        )
      ),
      leadingWidth: 75,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(MingCuteIcons.mgc_left_line),
          ),
          IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              MingCuteIcons.mgc_chat_4_line,
              size: 24,
            ),
          )
        ],
      ),
      titleSpacing: 0,
      centerTitle: true,
      title: Wrap(
        spacing: 8,
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.purpleAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Icon(MingCuteIcons.mgc_ai_fill),
          ),
          Text('Ai助手',),
        ],
      ),
      actionsPadding: EdgeInsets.only(right: 8),
      actions: [
        IconButton(
          icon: Icon(
            MingCuteIcons.mgc_ghost_line,
            size: 24,
          ),
          onPressed: () {
            
          },
        ),
      ],
    ),
    drawer: Drawer(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Ai助手',
                  style: TextStyle(
                    fontSize: 18,
                  )
                ),
                Spacer(),
                IconButton(
                  icon: Icon(MingCuteIcons.mgc_search_3_line),
                  onPressed: () {
                    
                  },
                )
              ],
            ),
            Gap(16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: Icon(MingCuteIcons.mgc_chat_4_line),
                label: Text(
                  '新建聊天',
                ),
                onPressed: () {
                  
                },
              ),
            ),
            Gap(8),
            ListTile(
              leading: Icon(MingCuteIcons.mgc_bookmark_line),
              trailing: Icon(MingCuteIcons.mgc_right_line),
              title: Text(
                '我的收藏',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                
              },
            ),
            Divider(
              color: Colors.black12,
            ),
            ListView(
              shrinkWrap: true,
              children: [],
            ),
            Spacer(),
            Divider(
              color: Colors.black12,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                ),
                Gap(8),
                Text(
                  '游客用户',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Badge(
                    child: Icon(MingCuteIcons.mgc_settings_3_line),
                  ),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Badge(
                    isLabelVisible: false,
                    child: Icon(MingCuteIcons.mgc_notification_line),
                  ),
                  onPressed: () {
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ),
    body: Stack(
      children: [
        Align(
          alignment: Alignment(0,-0.6),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            children: [
              Text(
                'Hi，很高兴见到你',
                style: TextStyle(
                  fontSize: 25,
                )
              ),
              SizedBox(
                width: 300,
                child: Text(
                  '我可以帮你创作各种创意，请把任务交给我吧~',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(
              bottom: 32,
              left: 12, right: 12
            ),
            child: Stack(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hint: Text('向 Ai助手 发送消息'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black26
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black54
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  maxLines: 3,
                ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Wrap(
                    spacing: 4,
                    children: [
                      OutlinedButton.icon(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )
                          ),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 8)
                          ),
                          textStyle: WidgetStatePropertyAll(
                            TextStyle(
                              fontSize: 12
                            )
                          ),
                          iconSize: WidgetStatePropertyAll(12),
                        ),
                        label: Text('深度思考'),
                        icon: Icon(MingCuteIcons.mgc_lightning_line),
                        onPressed: () {  },
                      ),
                      OutlinedButton.icon(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            )
                          ),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 8)
                          ),
                          textStyle: WidgetStatePropertyAll(
                            TextStyle(
                              fontSize: 12
                            )
                          ),
                          iconSize: WidgetStatePropertyAll(12)
                        ),
                        label: Text('联网搜索'),
                        icon: Icon(MingCuteIcons.mgc_earth_2_line),
                        onPressed: () {  },
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            MingCuteIcons.mgc_camera_2_ai_line,
                          ),
                          iconSize: 24,
                        )
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton.filled(
                          onPressed: () {},
                          icon: Icon(
                            MingCuteIcons.mgc_send_fill,
                            color: Colors.white,
                          ),
                          iconSize: 15,
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ],
    ),
  );
}