import 'dart:io';

import 'package:flutter/material.dart';

class AppThemeHolder{ 
  // 单例模式
  static final AppThemeHolder _instance = AppThemeHolder._internal();
  factory AppThemeHolder() => _instance;
  AppThemeHolder._internal();

  bool isLightThemeInit = false;
  late ThemeData lightTheme;
  bool isDarkThemeInit = false;
  late ThemeData darkTheme;

  final String globalFontFamily = 'fc-regular';
  final double buttonVerticalPadding = Platform.isAndroid? 14: 20;
  final double buttonHorizontalPadding = Platform.isAndroid? 16: 22;

  ThemeData getLightTheme(){
    if(!isLightThemeInit){
      lightTheme = ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.highContrastLight(
          primary: Color.fromARGB(255, 8, 168, 128),
        ),
        checkboxTheme: CheckboxThemeData(
          splashRadius: 0
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          ),
        ),

        tabBarTheme: TabBarThemeData(
          splashFactory: NoSplash.splashFactory,
          dividerHeight: 0,
        ),

        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            size: 22
          ),
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontFamily: globalFontFamily,
            color: Color(0xFF333333),
          )
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none
            ),
          ),
        ),

        listTileTheme: ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(vertical:4, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          horizontalTitleGap: 16,
          titleTextStyle: TextStyle(
            fontFamily: globalFontFamily,
            color: Color(0xFF333333),
            fontSize: 16
          ),
          tileColor: Colors.white,
          selectedTileColor: Colors.white,
          iconColor: Color(0xFF333333),
        ),

        badgeTheme: BadgeThemeData(
          backgroundColor: Colors.redAccent
        ),

        scaffoldBackgroundColor: Color(0xFFF5F5F5),

        drawerTheme: DrawerThemeData(
          backgroundColor: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
        ),

        bottomAppBarTheme: BottomAppBarThemeData(
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

        dialogTheme: DialogThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: buttonHorizontalPadding,
              vertical: buttonVerticalPadding,
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontFamily: globalFontFamily
            ),
            iconColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: buttonHorizontalPadding,
              vertical: buttonVerticalPadding,
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
            padding: EdgeInsets.symmetric(
              horizontal: buttonHorizontalPadding,
              vertical: buttonVerticalPadding
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontFamily: globalFontFamily
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
      isLightThemeInit = true;
    }
    return lightTheme;
  }

  ThemeData getDarkTheme(){
    if(!isDarkThemeInit){
      darkTheme = ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.highContrastDark(
          primary: Color.fromARGB(255, 60, 228, 186),
        ),
        checkboxTheme: CheckboxThemeData(
          splashRadius: 0
        ),
        switchTheme: SwitchThemeData(
          splashRadius: 0,
          thumbColor: WidgetStatePropertyAll(Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          )
        ),

        tabBarTheme: TabBarThemeData(
          splashFactory: NoSplash.splashFactory,
          dividerHeight: 0,
          unselectedLabelStyle: TextStyle(
            color: Colors.white
          ),
          labelColor: Colors.white,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2
            )
          )
        ),

        scaffoldBackgroundColor: Color(0xFF070707),

        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            size: 22,
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontFamily: globalFontFamily,
            color: Colors.white,
          )
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none
            ),
          ),
        ),

        listTileTheme: ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(vertical:4, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          horizontalTitleGap: 16,
          titleTextStyle: TextStyle(
            fontFamily: globalFontFamily,
            fontSize: 16,
            color: Colors.white,
          ),
          iconColor: Colors.white,
        ),

        badgeTheme: BadgeThemeData(
          backgroundColor: Colors.redAccent
        ),

        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
        ),

        bottomAppBarTheme: BottomAppBarThemeData(
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
            color: Colors.white
          ),

          iconColor: Colors.white,
          prefixIconColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xFF333333),
              width: 1
            )
          ),
        ),

        dialogTheme: DialogThemeData(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: buttonHorizontalPadding,
              vertical: buttonVerticalPadding,
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontFamily: globalFontFamily,
            ),
            foregroundColor: Colors.white,
            iconColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: buttonHorizontalPadding,
              vertical: buttonVerticalPadding,
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
            foregroundColor: Colors.white,
          )
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: buttonHorizontalPadding,
              vertical: buttonVerticalPadding
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontFamily: globalFontFamily,
            ),
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Colors.white,
          )
        ),
        
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            splashFactory: NoSplash.splashFactory,
            hoverColor: Colors.transparent
          ),
        ),
        fontFamily: globalFontFamily
      );
      isDarkThemeInit = true;
    }
    return darkTheme;
  }
}