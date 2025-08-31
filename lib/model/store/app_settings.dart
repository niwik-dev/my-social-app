import 'dart:ui';

class AppSettings{
  bool isDarkMode;
  Color? themePrimaryColor;
  bool useSysFont;
  double fontSize;
  int fontSizeIndex;

  AppSettings({
    this.isDarkMode = false,
    this.themePrimaryColor,
    this.useSysFont = false,
    this.fontSize = 16.0,
    this.fontSizeIndex = 2 // 中等
  });

  AppSettings copyWith({
    bool? isDarkMode,
    Color? themePrimaryColor,
    bool? useSysFont,
    double? fontSize,
    int? fontSizeIndex
  }){
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      themePrimaryColor: themePrimaryColor?? this.themePrimaryColor,
      useSysFont: useSysFont ?? this.useSysFont,
      fontSize: fontSize ?? this.fontSize,
      fontSizeIndex: fontSizeIndex ?? this.fontSizeIndex
    );
  }
}