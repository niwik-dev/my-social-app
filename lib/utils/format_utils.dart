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

 static String formatNumberCN(int? number){
    if(number == null){
      return '0';
    }
    if(number < 1000){
      return number.toString();
    }
    if(number>1_000&& number < 10_000){
      return '${(number/1_000).toStringAsFixed(1)}千';
    }
    if(number>10_000&& number < 10_000_000){
      return '${(number/10_000).toStringAsFixed(1)}万';
    }
    if(number>10_000_000&& number < 1_000_000_000){
      return '${(number/10_000_000).toStringAsFixed(1)}千万';
    }
    return '${(number/1_000_000_000).toStringAsFixed(1)}亿';
 }

 static DateTime parseTimestamp(int timestamp){
   return DateTime.fromMillisecondsSinceEpoch(timestamp * 1_000);
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

class ModernStyleFormatUtils { 
  // 以现代风格格式化

  static String dateFormatRedNote(DateTime dateTime){
    // 小红书格式化规则：
    // 0. 如果日期与当天相差不到20分钟，显示刚刚
    // 1. 如果日期与当天相差不到1小时，显示"xx分钟前"
    // 2. 如果日期与当天相差小于12小时，显示"xx小时前"
    // 3. 如果日期与当天相差小于1天，显示"今天 xx时xx分"
    // 3. 如果日期与当天相差小于2天，显示"昨天 xx时xx分"
    // 4. 如果日期与当天相差小于3天，显示"前天 xx时xx分"
    // 5. 如果日期与当天相差小于7天，显示"xx天前"
    // 6. 如果日期与当天相差小于30天，显示"xx月xx日"
    // 7. 如果日期与当天相差小于365天，显示"xx月xx日"
    // 8. 如果日期与当天相差大于365天，小于730天，显示 "去年"
    // 9. 如果日期与当天相差大于730天，显示"xxxx年xx月xx日"
    var now = DateTime.now();
    var difference = now.difference(dateTime);
    if (difference.inDays < 1) {
      return FormatUtils.formatDateTime(
        dateTime,
        format:"今天 HH:mm"
      );
    } else if (difference.inDays < 2) {
      return FormatUtils.formatDateTime(
        dateTime,
        format:"昨天 HH:mm"
      );
    } else if (difference.inDays < 3) {
      return FormatUtils.formatDateTime(
        dateTime,
        format:"前天 HH:mm"
      );
    } else if (difference.inDays < 7) {
      return "${difference.inDays}天前";
    } else if (difference.inDays < 30) {
      return FormatUtils.formatDateTime(
        dateTime,
        format:"MM-dd"
      );
    }else if (difference.inDays < 365) {
      return FormatUtils.formatDateTime(
        dateTime,
        format:"MM-dd"
      );
    } else {
      return FormatUtils.formatDateTime(
        dateTime,
        format:"yyyy-MM-dd"
      );
    }
  }
}