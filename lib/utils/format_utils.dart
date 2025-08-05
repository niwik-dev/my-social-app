class FormatUtils{
  static String formatNumber(int? number){
    if(number == null){
      return '0';
    }
    if(number < 1000){
      return number.toString();
    }
    if(number < 1000000){
      return '${(number/1000).toStringAsFixed(1)}K';
    }
    if(number < 1000000000){
      return '${(number/1000000).toStringAsFixed(1)}M';
    }
    return '${(number/1000000000).toStringAsFixed(1)}B';
 }

 static DateTime parseTimestamp(int timestamp){
   return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
 }

 static String formatDateTime(DateTime dateTime,{required String format}){
   return format
   .replaceAll('yy', dateTime.year.toString().padLeft(2, '0'))
   .replaceAll('MM', dateTime.month.toString().padLeft(2, '0'))
   .replaceAll('dd', dateTime.day.toString().padLeft(2, '0'))
   .replaceAll('HH', dateTime.hour.toString().padLeft(2, '0'))
   .replaceAll('mm', dateTime.minute.toString().padLeft(2, '0'))
   .replaceAll('ss', dateTime.second.toString().padLeft(2, '0'));
 }
}