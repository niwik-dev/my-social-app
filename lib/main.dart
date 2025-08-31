import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_social/router/app_router.dart';
import 'package:my_social/store/settings/settings_store.dart';
import 'package:my_social/theme/app_theme.dart';
import 'package:my_social/utils/window_utils.dart';

part 'main.g.dart';

void main(){
  runApp(MySocialApp());
}

@swidget
Widget mySocialApp(BuildContext context){
  AppRouterHolder routerHolder = AppRouterHolder();
  AppThemeHolder themeHolder = AppThemeHolder();

  WidgetsFlutterBinding.ensureInitialized();
  WindowUtils.initialize();
  MediaKit.ensureInitialized();

  return ProviderScope(
    child: SafeArea(
      child: Consumer(
        builder: (context, ref, child){
          var appSettings = ref.watch(appSettingsStoreProvider);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routerHolder.getRouter(),
            theme: appSettings.isDarkMode?
              themeHolder.getDarkTheme(
                primaryColor: appSettings.themePrimaryColor,
                useSysFont: appSettings.useSysFont,
                fontSize: appSettings.fontSize
              ): themeHolder.getLightTheme(
                primaryColor: appSettings.themePrimaryColor,
                useSysFont: appSettings.useSysFont,
                fontSize: appSettings.fontSize
              ),
          );
        },
      ),
    ),
  );
}