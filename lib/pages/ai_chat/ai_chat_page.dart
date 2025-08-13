import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/api/restful/auth_api.dart';
import 'package:my_social/api/restful/user_api.dart';
import 'package:my_social/model/store/ai_chat_sessions.dart';
import 'package:my_social/model/store/login_user.dart';
import 'package:my_social/model/view/session_prompt.dart';
import 'package:my_social/pages/ai_chat/ai_chat_header.dart';
import 'package:my_social/pages/ai_chat/chat_bubble.dart';
import 'package:my_social/pages/ai_chat/chat_topic_box.dart';
import 'package:my_social/service/ai_chat_service.dart';
import 'package:my_social/store/ai_chat/ai_chat_store.dart';
import 'package:my_social/store/login/login_store.dart';

part 'ai_chat_page.g.dart';

@swidget
Widget welcomeAiSubPage(BuildContext context) { 

  return Align(
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
  );
}

@hcwidget
Widget aiChatPage(BuildContext context,WidgetRef ref) { 
  GlobalKey<ScaffoldState> scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());
  
  AiChatService aiChatService = AiChatService();

  var inputContent = useState<String>("");
  var isDeepThink = useState<bool>(false);
  var isInternetSearch = useState<bool>(false);
  var currentSession = useState<AiChatSession?>(null);
  var isChatProcessing = useState<bool>(false);
  var canGotoTop = useState<bool>(false);
  var chatTopcis = useState<AiChatTopics>(
    AiChatTopics(
      topics: [
        AiChatPrompt(name: '图像处理', prompt: 'Photoshop高效操作指南'),
        AiChatPrompt(name: '功课辅导', prompt: '万有引力公式是怎么得出的？'),
        AiChatPrompt(name: '副业思路', prompt: '如何利用闲暇时间提高收入？'),
      ]
    )
  );

  var scrollController = useScrollController();
  var textEditController = useTextEditingController();

  var aiChatHistoryNotifier = ref.watch(aiChatHistoryStoreProvider.notifier);
  var loginUser = useState<LoginUser>(LoginUser());

  useEffect((){
    UserApi().getCurrnentUser(ref)
    .then((user) {
      if(user!=null){
        loginUser.value = user;
      }
    });

    listener(){
      if(scrollController.hasClients){
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );

        if(scrollController.initialScrollOffset > 80){
          canGotoTop.value = true;
        }else{
          canGotoTop.value = false;
        }
      }
    }
    currentSession.addListener(listener);
    return () => currentSession.removeListener(listener);
  },[]);

  Future<void> haveNewChat({
    required String content, bool newSession=false
  }) async {
    if(isChatProcessing.value){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请等待当前会话结束'),
          duration: Duration(seconds: 1),
        )
      );
      return;
    }

    if(newSession) currentSession.value = null;

    bool isNewSession;
    AiChatSession session;
    if(currentSession.value == null){
      isNewSession = true;
      // 新增空会话
      session = AiChatSession(
        title: '新对话',
        messages: []
      );
    }else{
      isNewSession = false;
      session = currentSession.value!;
    }

    session.addMessages([
      AiChatMessage(
          content: content,
          role: 'user',
      ),
      AiChatMessage(
          content: '',
          role: 'assistant',
      )
    ]);
    aiChatHistoryNotifier.saveSession(session);
    currentSession.value = session.copy();

    aiChatService.makeNewChat(
      ref,
      session: session,
      content: inputContent.value,
      isDeepThink: isDeepThink.value,
      isInternetSearch: isInternetSearch.value,
      onProcess: (session){
        isChatProcessing.value = true;
        currentSession.value = session;
      },
      onFinished: () {
        isChatProcessing.value = false;
      },
    );

    // 生成会话标题内容
    if(isNewSession){
      aiChatService.renameNewChat(
        ref,
        session: session,
        content: content
      );
    }

    chatTopcis.value = await aiChatService.generatePrompt(
      ref, session
    );
  };

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
                  currentSession.value = null;
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
            ),
            Gap(8),
            ListTile(
              style: ListTileStyle.list,
              dense: true,
              leading: Icon(
                MingCuteIcons.mgc_bookmark_line,
                size: 18,
              ),
              trailing: Icon(MingCuteIcons.mgc_right_line),
              title: Text(
                '我的收藏',
                style: TextStyle(
                  fontSize: 16,
                )
              ),
              onTap: () {
                
              },
            ),
            Divider(
              color: Colors.black12,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ...aiChatHistoryNotifier.getSessions().map(
                  (AiChatSession session){
                    return ListTile(
                      dense: true,
                      leading: Icon(
                        MingCuteIcons.mgc_chat_1_line,
                        size: 18,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          MingCuteIcons.mgc_delete_3_line,
                          size: 18,
                        ),
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('操作'),
                              content: Text('是否删除该会话？'),
                              actions: [
                                OutlinedButton(
                                  child: Text('取消'),
                                  onPressed: (){
                                    context.pop();
                                  }
                                ),
                                FilledButton(
                                  child: Text('确定'),
                                  onPressed: (){
                                    aiChatHistoryNotifier.removeSession(session);
                                    if(currentSession.value!=null && currentSession.value!.uuid == session.uuid){
                                      currentSession.value = null;
                                    }
                                    context.pop();
                                  }
                                ),

                              ]
                            )
                          );
                        }
                      ),
                      title: Text(
                        session.title,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        currentSession.value = aiChatHistoryNotifier.getSession(
                          session.uuid
                        );
                        scaffoldKey.currentState?.closeDrawer();
                      },
                    );
                  }
                )
              ],
            ),
            Spacer(),
            Divider(
              color: Colors.black12,
            ),
            Row(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: loginUser.value.avatarUrl!=null?
                    Image.network(
                      loginUser.value.avatarUrl!,
                    ): Icon(MingCuteIcons.mgc_user_3_fill),
                  ),
                ),
                Gap(8),
                Text(
                  loginUser.value.nickname!,
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
        currentSession.value == null? WelcomeAiSubPage():
        CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: ChatHistoryHeaderBarDelegate(
                title: currentSession.value!.title,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
                child: Center(
                  child: Text(
                    'ai生成内容仅供参考',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
            for(var message in currentSession.value!.messages)
              SliverToBoxAdapter(
                child: ChatBubble(
                  text: (message.content).trim(),
                  isUser: message.role == 'user',
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 200),
            )
          ],
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(!isChatProcessing.value)
                    SizedBox(
                      height: 64,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for(AiChatPrompt topic in chatTopcis.value.topics)
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: ChatTopicBox(
                              title: topic.name,
                              subtitle: topic.prompt,
                              onTap: () {
                                haveNewChat(content: topic.prompt);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(8),
                    TextField(
                      controller: textEditController,
                      enabled: !isChatProcessing.value,
                      onChanged: (value) {
                        inputContent.value = value;
                      },
                      style: const TextStyle(
                        fontSize: 15
                      ),
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
                    )
                  ],
                ),

                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Wrap(
                    spacing: 4,
                    children: [
                      OutlinedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            isDeepThink.value?Colors.black87:Colors.white,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            isDeepThink.value?Colors.white:Colors.black87,
                          ),
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
                        onPressed: () {
                          isDeepThink.value = !isDeepThink.value;
                        },
                      ),
                      OutlinedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            isInternetSearch.value?Colors.black87:Colors.white,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            isInternetSearch.value?Colors.white:Colors.black87,
                          ),
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
                        onPressed: () {
                          isInternetSearch.value = !isInternetSearch.value;
                        },
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
                          onPressed: () {
                            // 清空输入框
                            textEditController.clear();
                            haveNewChat(content: inputContent.value);
                          },
                          icon: Icon(
                            isChatProcessing.value?
                            MingCuteIcons.mgc_stop_fill:
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