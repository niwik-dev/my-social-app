import 'dart:convert';

class JsonUtils {
  static final jsonRegex = RegExp(
    r'{.*}',
    caseSensitive: false,
    multiLine: true,
    dotAll: true,
  );

  static Map<String, dynamic>? extractJsonFromText(String text) {
    final matches = jsonRegex.allMatches(text);
    for (final match in matches) {
      try {
        final jsonString = match.group(0)!;
        final json = jsonDecode(jsonString);
        if (json is Map<String, dynamic>) {
          return json;
        }
      } catch (e) {
        // 忽略解析错误
      }
    }
    return null;
  }

  // 从文本中提取JSON
  static List<Map<String,dynamic>> extractJsonListFromText(String text) {
    final matches = jsonRegex.allMatches(text);
    final jsonList = <Map<String,dynamic>>[];
    
    for (final match in matches) {
      try {
        final jsonString = match.group(0);
        if (jsonString != null) {
          final jsonData = json.decode(jsonString) as Map<String, dynamic>;
          jsonList.add(jsonData);
        }
      } catch (e) {
        // 如果JSON解析失败，跳过这个匹配
        continue;
      }
    }
    return jsonList;
  }
}