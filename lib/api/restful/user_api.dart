import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/model/store/login_user.dart';
import 'package:my_social/store/login/login_store.dart';
import 'package:my_social/utils/request_utils.dart';

class UserApi{
  // 单例模式
  static final UserApi _instance = UserApi._internal();
  factory UserApi() => _instance;
  UserApi._internal();

  Future<LoginUser?> updateCurrnentUser(WidgetRef ref) async{
    String url = "/api/v1/users/me";
    Response response = await AuthRequestUtils.get(
      ref,
      url,
    );
    if(response.statusCode == 200){
      var loginUserStore = ref.read(loginUserStoreProvider);
      var loginUserStoreNotifier = ref.read(loginUserStoreProvider.notifier);
      LoginUser loginUser = LoginUser(
        accessToken: loginUserStore.accessToken,
        refreshToken: loginUserStore.refreshToken,
        isLoggedIn: loginUserStore.isLoggedIn,
        username: response.data["data"]["username"],
        nickname: response.data["data"]["nickname"],
        email: response.data["data"]["email"],
        mobile: response.data["data"]["mobile"],
        avatarUrl: response.data["data"]["avatar"],
      );
      loginUserStoreNotifier.setLoginUser(loginUser);
      return loginUser;
    }
    return null;
  }

  Future<LoginUser?> getCurrnentUser(WidgetRef ref) async{
    String url = "/api/v1/users/me";
    Response response = await AuthRequestUtils.get(
      ref,
      url,
    );
    if(response.statusCode == 200){
      var loginUserStore = ref.read(loginUserStoreProvider);
      var loginUserStoreNotifier = ref.read(loginUserStoreProvider.notifier);
      LoginUser loginUser = LoginUser(
        accessToken: loginUserStore.accessToken,
        refreshToken: loginUserStore.refreshToken,
        isLoggedIn: loginUserStore.isLoggedIn,
        username: response.data["data"]["username"],
        nickname: response.data["data"]["nickname"],
        email: response.data["data"]["email"],
        mobile: response.data["data"]["mobile"],
        avatarUrl: response.data["data"]["avatar"],
      );
      return loginUser;
    }
    return null;
  }
}