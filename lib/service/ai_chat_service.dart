import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/api/restful/ai_chat_api.dart';
import 'package:my_social/model/request/chat_completions_body.dart';
import 'package:my_social/model/response/chat_completions_result.dart';
import 'package:my_social/model/response/chat_completions_stream_result.dart';
import 'package:my_social/model/store/ai_chat_sessions.dart' show AiChatSession;
import 'package:my_social/model/view/session_prompt.dart';
import 'package:my_social/store/ai_chat/ai_chat_store.dart';
import 'package:my_social/utils/json_utils.dart';

class AiChatService {
  // 单例模式
  static final AiChatService _instance = AiChatService._internal();
  factory AiChatService() => _instance;
  AiChatService._internal();
  
  final AiChatApi aiChatApi = AiChatApi();

  Future<void> makeNewChat(
    WidgetRef ref,
    {
      required AiChatSession session,
      required String content,
      required bool isDeepThink,
      required bool isInternetSearch,
      Function(AiChatSession)? onProcess,
      Function()? onFinished
    }
  ) async {
    bool isContentFected = false;
    var aiChatHistoryNotifier = ref.read(aiChatHistoryStoreProvider.notifier);
    aiChatApi.getChatCompletionsStream(
      body: ChatCompletionsBody(
        model: isDeepThink?"deepseek-ai/DeepSeek-R1-Distill-Qwen-32B":"deepseek-ai/DeepSeek-R1-0528-Qwen3-8B",
        messages: [
          for(var messgae in session.messages)
          MessageBody(
            role: messgae.role,
            content: messgae.content
          )
        ]
      ),
      onReceive: (ChatCompletionsStreamResult result){
        String? deltaReasoningContent = result.choices?.first.delta?.reasoningContent;
        String? deltaContent = result.choices?.first.delta?.content;
        var content = session.messages.last.content;
        if(deltaReasoningContent != null){ 
          if(!isContentFected){ 
            content = "";
            isContentFected = true;
          }
          content += deltaReasoningContent;
        }
        else if(deltaContent != null){
          if(!isContentFected){
            content = "";
            isContentFected = true;
          }
          content += deltaContent;
        }
        session.messages.last.content = content.trimLeft();
        aiChatHistoryNotifier.updateSession(session);

        if(onProcess!=null){
          onProcess(session.copy());
        }
      },
      onFinished: onFinished,
    );
  }

  /*
    重命名已有会话的标题
  */
  void renameNewChat(
    WidgetRef ref,
    {
      required AiChatSession session,
      required String content,
    }
  ){
    var aiChatHistoryNotifier = ref.watch(aiChatHistoryStoreProvider.notifier);

    var isTitleFected = false;
    aiChatApi.getChatCompletionsStream(
      body: ChatCompletionsBody(
        model: "deepseek-ai/DeepSeek-R1-0528-Qwen3-8B",
        messages: [
          MessageBody(
            role: 'system',
            content: '请你根据用户的问题，总结字数不超过20字的短语'
          ),
          
          MessageBody(
            role: "user",
            content: content
          )
        ]
      ),
      onReceive: (ChatCompletionsStreamResult result){
        String? deltaContent = result.choices?.first.delta?.content;
        var title = session.title;
        if(deltaContent != null){
          if(!isTitleFected && deltaContent.isNotEmpty){
            title = "";
            isTitleFected = true;
          }
          title += deltaContent;
        }
        session.title = title.trim();
        aiChatHistoryNotifier.updateSession(session);
      }
    );
  }

  /*
    根据现有的会话生成提示词
   */
  Future<AiChatTopics> generatePrompt(
    WidgetRef ref,
    AiChatSession session
  ) async { 
    AiChatTopics topics = AiChatTopics();
    String answer = "";

    ChatCompletionsResult result = await aiChatApi.chatCompletions(
      ChatCompletionsBody(
        maxTokens: 256,
        model: "deepseek-ai/DeepSeek-R1-0528-Qwen3-8B",
        messages: [
          for(var messgae in session.messages)
            MessageBody(
              role: messgae.role,
              content: messgae.content
            ),
          MessageBody(
            role: 'system',
            content: '''
            请你根据以上会话内容，预测用户感兴趣的话题，严格输出一个确保完整的json格式，不要输出多余的内容。
            json格式如下：
            {
              "topics":[
                {
                  "name":"用户可能感兴趣的话题名称，不多于10个字",
                  "prompt":"用户在这个话题上对话时需要的提示词，不多于20个字"
                }
              ]
            }
            '''.trim()
          ),
        ]
      )
    );

    answer = result.choices!.first.message!.content!;
    var jsonResult = JsonUtils.extractJsonFromText(answer);
    if(jsonResult!=null){
      if(jsonResult.containsKey("topics")){
        topics = AiChatTopics.fromJson(jsonResult);
      }
    }

    return Future.value(
      topics
    );
  }
}