import 'dart:io';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'option_toggle_button.g.dart';

@hwidget
Widget optionToggleButton(
  BuildContext context,  
{
  required Widget label,
  required Widget icon,
  required Function(bool) onChanged
}) { 
  final double buttonVerticalPadding = Platform.isAndroid? 0: 16;
  var selected = useState(false);
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return OutlinedButton.icon(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
        isDark ^ selected.value?Colors.black87:Colors.white,
      ),
      foregroundColor: WidgetStatePropertyAll(
        isDark ^ selected.value?Colors.white:Colors.black87,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )
      ),
      minimumSize: WidgetStatePropertyAll(
          Size(0,32)
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 8,
          vertical: buttonVerticalPadding
        )
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 12
        )
      ),
      iconSize: WidgetStatePropertyAll(12)
    ),
    label: label,
    icon: icon,
    onPressed: () {
      selected.value = !selected.value;
      onChanged.call(selected.value);
    },
  );
}