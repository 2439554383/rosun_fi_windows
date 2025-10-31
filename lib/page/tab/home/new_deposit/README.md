# 新入金功能模块

## 功能概述

基于API文档和UI设计图，创建了完整的新入金功能模块，包括：

### 1. 入金申请功能
- 电汇入金申请页面 (`deposit_application_page.dart`)
- 银行选择功能
- 金额输入和服务费计算
- 凭证上传功能（待实现）
- 成功页面展示

### 2. 入金列表功能
- 入金记录列表 (`deposit_list_page.dart`)
- 出金记录列表
- 状态显示（待审核/已完成/交易失败）
- 下拉刷新功能

### 3. 数据模型
- `NewDepositRequest` - 入金申请数据模型
- `DepositBank` - 银行信息模型
- `NewWithdrawRequest` - 出金申请数据模型
- 完整的JSON序列化支持

### 4. API集成
- 入金申请：`POST /api/deposit/request`
- 入金列表：`GET /api/deposit/request/list`
- 银行列表：`GET /api/depositBank/list`
- 服务费查询：`GET /api/deposit/request/serviceCharge`
- 出金列表：`GET /api/withdraw/request/list`

## 使用方法

### 1. 路由跳转
```dart
// 跳转到出入金流水页面
Get.toNamed('/newDeposit');

// 跳转到入金申请页面
Get.toNamed('/newDepositApplication');

// 跳转到成功页面（带参数）
Get.toNamed('/newDepositSuccess', arguments: {
  'amount': 400000.0,
  'bank': '【中国香港】花旗银行(4546)',
  'serviceCharge': 0.0,
  'currency': 'HKD',
});
```

### 2. 控制器使用
```dart
// 获取控制器实例
final controller = Get.find<NewDepositCtrl>();

// 提交入金申请
controller.submitDeposit();

// 刷新列表
controller.refreshDepositList();

// 选择银行
controller.selectBank(bank);

// 查询服务费
controller.getServiceCharge();
```

## 页面结构

```
lib/page/tab/home/new_deposit/
├── new_deposit_page.dart          # 主页面（出入金流水）
├── deposit_application_page.dart  # 入金申请页面
├── deposit_list_page.dart         # 入金列表页面
├── deposit_success_page.dart      # 成功页面
├── new_deposit_ctrl.dart          # 控制器
└── README.md                      # 说明文档
```

## 特色功能

1. **完整的UI设计** - 按照提供的设计图实现
2. **状态管理** - 使用GetX进行状态管理
3. **API集成** - 完整的API接口调用
4. **错误处理** - 完善的错误提示机制
5. **响应式设计** - 使用ScreenUtil适配不同屏幕
6. **代码规范** - 遵循项目代码规范

## 待完善功能

1. 图片上传功能（凭证上传）
2. 出金申请功能
3. 更多银行信息展示
4. 交易详情页面
5. 推送通知集成

## 注意事项

1. 确保API接口地址正确配置
2. 需要实现图片选择器功能
3. 根据实际API响应调整数据模型
4. 测试各种异常情况的处理
