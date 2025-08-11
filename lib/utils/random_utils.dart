import 'dart:math';

class RandomUtils {
  // 生成随机数的工具类

  static List<String> subjectName = [
    '无花果','蜜桔','乌梅','南瓜','蔓越莓',
    '茴香','芋头','皮卡丘','平菇','豌豆荚',
    '青菜','妙蛙种子','紫甘蓝','珍珠鸟','小麻雀',
    '哈士奇','泰迪熊','加菲猫','小叮当','米老鼠',
    '兔八哥','水濑', '卡皮巴拉','孙悟空'
  ];

  static List<String> placeName = [
    '星空岛', '浪浪山', '浅草谷', '故河畔', '杜甫草堂',
    '玫瑰园', '北境之地', '西风岭', '小渔村', '溪山寺',
    '车管所', '停车场', '售楼处', '保安厅', '工位',
    '街道办', '港口', '自来水厂', '咖啡厅', '学校'
  ];

  static List<String> actionName = [
    '保护师傅', '很想你', '忘带身份证', '想吃小炒肉', '肚子饿',
    '发呆中', '转圈圈', '困得很', '孤芳自赏', '看风景',
    '备考上岸', '不吃香菜', '拼多多砍一刀', '刷朋友圈', '送外卖',
    '吃早餐', '口袋空空', '摸鱼', '后空翻', '卖炒饭'
  ];

  static String buildRandomNickName(){
    return
        subjectName[Random().nextInt(placeName.length)] + '在' +
        placeName[Random().nextInt(placeName.length)] +
        actionName[Random().nextInt(actionName.length)];
  }
}