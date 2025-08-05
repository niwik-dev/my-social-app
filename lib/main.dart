import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_social/router/app_router.dart';
import 'package:my_social/theme/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main(){
  runApp(MySocialApp());
}

@swidget
Widget mySocialApp(BuildContext context){
  AppRouterHolder routerHolder = AppRouterHolder();
  AppThemeHolder themeHolder = AppThemeHolder();

  return ProviderScope(
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerHolder.getRouter(),
      theme: themeHolder.getTheme(),
    ),
  );
}