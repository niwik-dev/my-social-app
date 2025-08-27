import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/model/store/app_settings.dart';
import 'package:my_social/store/settings/settings_store.dart';

part 'general_setting_page.g.dart';

@hcwidget
Widget generalSettingPage(BuildContext context, WidgetRef ref){
  var appSettings = ref.watch(appSettingsStoreProvider);
  var appSettingsNotifier = ref.watch(appSettingsStoreProvider.notifier);

  return Scaffold(
    appBar: AppBar(
      title: Text('通用设置'),
      centerTitle: true,
    ),
    body: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0
      ),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: Text('显示'),
              ),
              ListTile(
                leading: Icon(MingCuteIcons.mgc_moon_line),
                title: Text('深色模式'),
                trailing: Switch(
                  value: appSettings.isDarkMode,
                  onChanged: (value) {
                    appSettingsNotifier.updateAppSettings(
                      appSettings.copyWith(
                        isDarkMode: value
                      )
                    );
                  },
                )
              ),
              ListTile(
                leading: Icon(MingCuteIcons.mgc_color_filter_line),
                title: Text('主题颜色'),
                trailing: Icon(MingCuteIcons.mgc_right_line),
                onTap: () {
                  
                },
              ),
              ListTile(
                leading: Icon(MingCuteIcons.mgc_font_line),
                title: Text('使用系统默认字体'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {
                  },
                )
              ),
              ListTile(
                leading: Icon(MingCuteIcons.mgc_font_size_line),
                title: Text('字体大小'),
                trailing: Icon(MingCuteIcons.mgc_right_line),
                onTap: () {
                  
                },
              )
            ])
          )
        ],
      ),
    )
  );
}