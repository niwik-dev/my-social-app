import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

AppBar defaultAppBar(){
  return AppBar(
    actionsPadding: EdgeInsets.all(8),
    actions: [
      IconButton(
        onPressed: (){},
        icon: Badge(
          child: Icon(MingCuteIcons.mgc_bell_ringing_line),
        ),
      )
    ],
  );
}