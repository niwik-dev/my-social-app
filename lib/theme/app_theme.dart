import 'package:flutter/material.dart';

class AppThemeHolder{ 
  // 单例模式
  static final AppThemeHolder _instance = AppThemeHolder._internal();
  factory AppThemeHolder() => _instance;
  AppThemeHolder._internal();

  bool isInit = false;
  late ThemeData theme;

  final String globalFontFamily = 'fc-regular';

  ThemeData getTheme(){ 
    if(!isInit){
      theme = ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.highContrastLight(
          primary: Colors.black87
        ),
        checkboxTheme: CheckboxThemeData(
          splashRadius: 0
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            size: 20
          )
        ),

        listTileTheme: ListTileThemeData(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          horizontalTitleGap: 12,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontFamily: globalFontFamily,
            color: Color(0xFF333333),
          ),
          tileColor: Colors.white,
          selectedTileColor: Colors.white,
          iconColor: Color(0xFF333333),
        ),

        badgeTheme: BadgeThemeData(
          backgroundColor: Colors.redAccent
        ),

        drawerTheme: DrawerThemeData(
          backgroundColor: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
        ),

        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xFFF5F5F5),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF333333),
          foregroundColor: Colors.white,
          shape: CircleBorder()
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,

          hintStyle: TextStyle(
            color: Colors.black26
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xFF333333),
              width: 1
            )
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 18
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontFamily: globalFontFamily
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 18
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontFamily: globalFontFamily
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Color(0xFF333333)
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Color(0xFF333333),
          )
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Color(0xFF333333),
          )
        ),
        
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Color(0xFF333333),
            splashFactory: NoSplash.splashFactory,
            hoverColor: Colors.transparent
          ),
        ),
        fontFamily: globalFontFamily
      );
      isInit = true;
    }
    return theme;
  }
}