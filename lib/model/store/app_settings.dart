import 'dart:ui';

class AppSettings{
  bool isDarkMode;
  Color themeColor;

  AppSettings({
    this.isDarkMode = false,
    this.themeColor = const Color.fromARGB(255, 60, 228, 186)
  });

  AppSettings copyWith({
    bool? isDarkMode,
    Color? themeColor,
  }){
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}