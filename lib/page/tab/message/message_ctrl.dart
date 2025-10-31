import 'package:get/get.dart';

class MessageCtrl extends GetxController {
  int selectedCategory = 0;
  List<String> categories = ['全部', '系统通知', '交易提醒', '市场资讯'];

  List<Map<String, dynamic>> allMessages = [
    {
      'title': '交易成功通知',
      'content': '您的腾讯控股买入订单已成功执行，数量：500股，价格：¥320.00',
      'time': '10:30',
      'type': 'trade',
      'isRead': false,
    },
    {
      'title': '系统维护通知',
      'content': '系统将于今晚22:00-24:00进行维护，期间可能影响部分功能使用',
      'time': '09:15',
      'type': 'system',
      'isRead': false,
    },
    {
      'title': '市场行情提醒',
      'content': '比亚迪股价上涨超过5%，建议关注后续走势',
      'time': '昨天',
      'type': 'market',
      'isRead': true,
    },
    {
      'title': '账户安全提醒',
      'content': '检测到异常登录，如非本人操作请及时修改密码',
      'time': '昨天',
      'type': 'system',
      'isRead': true,
    },
    {
      'title': '交易提醒',
      'content': '您的美团卖出订单已部分成交，剩余200股等待成交',
      'time': '前天',
      'type': 'trade',
      'isRead': true,
    },
    {
      'title': '市场资讯',
      'content': '科技股整体表现强劲，建议关注相关板块投资机会',
      'time': '前天',
      'type': 'market',
      'isRead': true,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _initializeData() {
    print('MessageCtrl 初始化完成');
  }

  void selectCategory(int index) {
    selectedCategory = index;
    update();
  }

  List<Map<String, dynamic>> getMessageList() {
    if (selectedCategory == 0) {
      return allMessages;
    }

    String type = '';
    switch (selectedCategory) {
      case 1:
        type = 'system';
        break;
      case 2:
        type = 'trade';
        break;
      case 3:
        type = 'market';
        break;
    }

    return allMessages.where((message) => message['type'] == type).toList();
  }

  void readMessage(int index) {
    final messageList = getMessageList();
    if (index < messageList.length) {
      final message = messageList[index];
      final allIndex = allMessages.indexOf(message);
      if (allIndex != -1) {
        allMessages[allIndex]['isRead'] = true;
        update();
      }
    }
  }
}
