import 'package:my_social/model/store/openim_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'openim_store.g.dart';

@riverpod
class OpenIMStore extends _$OpenIMStore {
  @override
  OpenIMState build() {
    return OpenIMState();
  }

  void update(OpenIMState state) {
    state = state;
  }
}