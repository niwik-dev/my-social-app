import 'package:my_social/model/store/ai_chat_sessions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_chat_store.g.dart';

@riverpod
class AiChatHistoryStore extends _$AiChatHistoryStore {
  @override
  List<AiChatSession> build() {
    return <AiChatSession>[];
  }

  void orderByCreateTime(){
    state = state..sort((a, b) => b.createTime.compareTo(a.createTime));
  }

  void saveSession(AiChatSession session){
    bool isExist = false;
    for(var i = 0; i < state.length; i++){
      if(state[i].uuid == session.uuid){
        isExist = true;
        break;
      }
    }
    if(!isExist){
      addSession(session);
    }else{
      updateSession(session);
    }
  }

  List<AiChatSession> getSessions() {
    return state;
  }

  void addSession(AiChatSession session) {
    state = [session,...state];
    orderByCreateTime();
  }

  void removeSession(AiChatSession session) {
    state = state.where(
      (element) => element.uuid != session.uuid
    ).toList();
  }
  
  void updateSession(AiChatSession session) {
    state = state.map(
      (element) => element.uuid == session.uuid ? session : element
    ).toList();
  }

  AiChatSession? getSession(String uuid) {
    return state.where(
      (element) => element.uuid == uuid
    ).firstOrNull;
  }
}