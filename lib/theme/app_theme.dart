import 'dart:io';

import 'package:flutter/material.dart';

class AppThemeHolder{ 
  // 单例模式
  static final AppThemeHolder _instance = AppThemeHolder._internal();
  factory AppThemeHolder() => _instance;
  AppThemeHolder._internal();

  bool isLightThemeInit = false;
  late ThemeData lightTheme;
  final Color lightPrimaryColor = Color.fromARGB(255, 8, 168, 128);

  bool isDarkThemeInit = false;
  late ThemeData darkTheme;
  final Color darkPrimaryColor = Color.fromARGB(255, 60, 228, 186);

  final String globalFontFamily = 'fc-regular';
  final double buttonVerticalPadding = Platform.isAndroid? 14: 20;
  final double buttonHorizontalPadding = Platform.isAndroid? 16: 22;

  ThemeData getLightTheme({
    bool? useSysFont,
    Color? primaryColor,
    double? fontSize
  }){
    if(!isLightThemeInit 
      || primaryColor != null || useSysFont != null || fontSize != null
    ){
      lightTheme = ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.highContrastLight(
          primary: primaryColor??lightPrimaryColor,
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
        expansionTileTheme: ExpansionTileThemeData(
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide.none
          ),
          collapsedBackgroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide.none
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
            fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null,
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
            fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null,
            color: Color(0xFF333333),
            fontSize: fontSize?? 16
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

        switchTheme: SwitchThemeData(
          splashRadius: 0,
          thumbColor: WidgetStateProperty.resolveWith(
            (Set<WidgetState> states){
              if(states.contains(WidgetState.selected)){
                return Colors.white;
              }
              return Colors.black;
            }
          ),
          trackOutlineWidth: WidgetStatePropertyAll(1)
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
              fontSize: fontSize??16,
              fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null
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
              fontSize: fontSize??16,
              fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null
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
              fontSize: fontSize??16,
              fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null
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
        fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null
      );
      isLightThemeInit = true;
    }
    return lightTheme;
  }

  ThemeData getDarkTheme({
    bool? useSysFont,
    Color? primaryColor,
    double? fontSize
  }){
    if(!isDarkThemeInit || primaryColor != null || useSysFont != null){
      darkTheme = ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.highContrastDark(
          primary: primaryColor??darkPrimaryColor,
        ),
        checkboxTheme: CheckboxThemeData(
          splashRadius: 0
        ),
        switchTheme: SwitchThemeData(
          splashRadius: 0,
          thumbColor: WidgetStatePropertyAll(Colors.white),
          trackOutlineWidth: WidgetStatePropertyAll(1)
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
        expansionTileTheme: ExpansionTileThemeData(
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide.none
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide.none
          ),
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
            fontSize: fontSize??16,
            fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null,
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
            fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null,
            fontSize: fontSize??16,
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
              fontSize: fontSize??16,
              fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null,
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
              fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null
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
              fontSize: fontSize??16,
              fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null,
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
        fontFamily: useSysFont==null||!useSysFont? globalFontFamily:null
      );
      isDarkThemeInit = true;
    }
    return darkTheme;
  }
}