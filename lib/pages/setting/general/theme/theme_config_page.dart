import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:my_social/store/settings/settings_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_social/theme/app_theme.dart';

part 'theme_config_page.g.dart';

@hcwidget
Widget themeConfigPage(WidgetRef ref, BuildContext context) {
  var appSettings = ref.watch(appSettingsStoreProvider);
  var appSettingsNotifier = ref.watch(appSettingsStoreProvider.notifier);

  return Scaffold(
    appBar: AppBar(
      title: Text('主题配置'),
      centerTitle: true,
    ),
    body: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0
      ),
      child: CustomScrollView(
        slivers: [
          SliverList.list(
            children: [
              ListTile(
                leading: Icon(MingCuteIcons.mgc_color_filter_line),
                title: Text('主题色'),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child:ColorPicker(
                        pickerColor: appSettings.themePrimaryColor??
                        AppThemeHolder().lightPrimaryColor,
                        onColorChanged: (Color color) {
                          appSettingsNotifier.updateAppSettings(
                            appSettings.copyWith(
                              themePrimaryColor: color
                            )
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}