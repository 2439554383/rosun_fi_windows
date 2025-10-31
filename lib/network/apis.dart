import '../config/env_config.dart';

class Api {
  // 自动从配置文件读取环境
  static String get host => Config.apiHost;

  static String baseUrl = '$host';
  static String imageUrl(String id) {
    if (id.isEmpty) return id;

    // 如果已经是完整URL
    if (id.startsWith('http://') || id.startsWith('https://')) {
      return id;
    }

    // 相对路径，正常拼接
    return '$baseUrl$id';
  }

  static const String checkPassword = "/api/user/valid/trade/password"; //验证交易密码

  // 入金相关接口
  static const String depositApplication = "/api/deposit/application"; //申请入金
  static const String depositList = "/api/deposit/list"; //获取入金列表

  // 新入金接口
  static const String newDepositRequest = "/api/deposit/request"; //新增入金申请
  static const String newDepositRequestList =
      "/api/deposit/request/list"; //查询入金申请列表
  static const String newDepositRequestDetail =
      "/api/deposit/request"; //查询入金申请详情
  static const String newDepositBankList = "/api/depositBank/list"; //查询入金银行列表
  static const String newDepositServiceCharge =
      "/api/deposit/request/serviceCharge"; //查询入金服务费

  // 出金相关接口
  static const String withdrawRequest = "/api/withdraw/request"; //出金申请
  static const String withdrawRequestList =
      "/api/withdraw/request/list"; //查询出金申请列表
  static const String withdrawRequestDetail =
      "/api/withdraw/request"; //查询出金申请详情
}
