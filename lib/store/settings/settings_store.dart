import 'package:my_social/model/store/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_store.g.dart';

@riverpod
class AppSettingsStore extends _$AppSettingsStore { 
  @override
  AppSettings build(){
    return AppSettings();
  } 

  void updateAppSettings(AppSettings appSettings){
    state = appSettings;
  }

  AppSettings getAppSettings(){
    return state;
  }
}