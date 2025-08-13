import 'package:uuid/uuid.dart';

class AiChatMessage{
  String? role;
  String content;
  String reasoningContent;

  AiChatMessage({
    this.role,
    this.content = "",
    this.reasoningContent = "",
  });

  AiChatMessage copy(){
    return AiChatMessage(
      role: role,
      content: content,
      reasoningContent: reasoningContent,
    );
  }
}

class AiChatSession{
  late String uuid;
  late DateTime createTime;
  late DateTime updateTime;

  String title;
  List<AiChatMessage> messages;

  AiChatSession({
    required this.title,
    required this.messages,
    String? uuid
  }){
    if(uuid == null){
      this.uuid = const Uuid().v4();
    }else{
      this.uuid = uuid;
    }
    createTime = DateTime.now();
    updateTime = DateTime.now();
  }

  AiChatSession copy(){
    return AiChatSession(
      uuid: uuid,
      title: title,
      messages: [
        for(var message in messages)
          message.copy(),
      ],
    );
  }

  void addMessages(List<AiChatMessage> newMessages){
    messages.addAll(newMessages);
  }

  void addMessage(AiChatMessage message) {
    messages.add(message);
  }

  void removeMessage(AiChatMessage message) {
    messages.remove(message);
  }
}