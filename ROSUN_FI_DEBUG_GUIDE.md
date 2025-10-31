# Rosun Fi - AI智能调试使用指南

## 🎯 为您的项目定制的AI调试系统

### 📱 快速开始

#### 1. 运行您的项目
```bash
flutter run --debug
```

#### 2. 体验AI调试功能
1. 启动应用后，您会看到两个浮动按钮
2. 点击蓝色的🐛按钮进入"AI调试演示"页面
3. 在演示页面中测试各种调试功能

### 🔧 在您的代码中使用AI调试

#### 基本用法示例

```dart
import 'util/ai_debug_helper.dart';

// 1. 记录函数调用
AIDebugHelper.logFunctionCall(
  'calculateAmounts',
  parameters: {
    'inputAmount': inputAmount,
    'leverage': leverage,
    'type': type.toString(),
  },
);

// 2. 记录状态变化
AIDebugHelper.logStateChange(
  'authorizedAmount',
  oldAuthorizedAmount,
  newAuthorizedAmount,
  reason: 'user_input_change',
);

// 3. 记录用户操作
AIDebugHelper.logUserAction(
  'Amount Calculation',
  context: {
    'inputValue': controller.text,
    'calculationType': 'TRS',
  },
  screen: 'FinancingPage',
);

// 4. 记录业务逻辑
AIDebugHelper.logBusinessLogic(
  'TRS Calculation',
  data: {
    'originalAmount': originalAuthorizedAmount,
    'inputAmount': inputAmount,
    'leverage': leverage,
    'result': authorizedAmount,
  },
  category: 'financing',
);

// 5. 记录错误（AI会自动分析）
try {
  // 您的业务逻辑
} catch (e, stackTrace) {
  AIDebugHelper.logError(
    'Calculation failed',
    e,
    stackTrace: stackTrace,
    context: 'calculateAmounts function',
    autoAnalyze: true,
  );
}
```

### 🚀 实际应用场景

#### 场景1：金融计算调试
```dart
void calculateAmounts() {
  // 记录函数开始
  AIDebugHelper.logFunctionCall('calculateAmounts', parameters: {
    'inputText': controller.text,
    'leverage': info.leverage,
    'type': type.toString(),
  });
  
  try {
    num? inputAmount = num.tryParse(controller.text);
    if (inputAmount == null) {
      AIDebugHelper.logBusinessLogic('Input validation failed', data: {
        'inputText': controller.text,
        'reason': 'invalid_number_format',
      });
      return;
    }
    
    double leverage = double.tryParse(info.leverage ?? '1') ?? 1.0;
    double originalAmount = UserData().financingAccount?.authorizedPurchasingPower ?? 0.0;
    
    // 记录计算过程
    AIDebugHelper.logBusinessLogic('TRS Calculation', data: {
      'inputAmount': inputAmount,
      'leverage': leverage,
      'originalAmount': originalAmount,
      'calculationType': type == FinancingType.ZJRZ ? '增加TRS' : '减少TRS',
    });
    
    if (type == FinancingType.ZJRZ) {
      authorizedAmount = originalAmount + (inputAmount * leverage + 1);
      interestAmount = originalInterestAmount + inputAmount;
    } else {
      authorizedAmount = originalAmount - (inputAmount * leverage + 1);
      interestAmount = originalInterestAmount - inputAmount;
    }
    
    // 记录计算结果
    AIDebugHelper.logStateChange('authorizedAmount', originalAmount, authorizedAmount);
    AIDebugHelper.logStateChange('interestAmount', originalInterestAmount, interestAmount);
    
  } catch (e, stackTrace) {
    AIDebugHelper.logError('Amount calculation failed', e, 
      stackTrace: stackTrace, context: 'calculateAmounts');
  }
}
```

#### 场景2：网络请求调试
```dart
Future<void> fetchUserData() async {
  const url = 'https://fi.rosuntrade.top/fiapi/user/profile';
  
  AIDebugHelper.logNetworkRequest('GET', url, headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  });
  
  try {
    final response = await http.get(Uri.parse(url));
    
    AIDebugHelper.logNetworkResponse(url, response.statusCode, 
      response: response.body, duration: Duration(milliseconds: 500));
    
    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      AIDebugHelper.logBusinessLogic('User data loaded', data: {
        'userId': userData['id'],
        'userName': userData['name'],
      });
    }
  } catch (e, stackTrace) {
    AIDebugHelper.logError('Network request failed', e, 
      stackTrace: stackTrace, context: 'fetchUserData');
  }
}
```

#### 场景3：状态管理调试
```dart
class FinancingController extends GetxController {
  void updateFinancingData(Map<String, dynamic> data) {
    AIDebugHelper.logFunctionCall('updateFinancingData', parameters: data);
    
    final oldData = financingData.value;
    
    try {
      financingData.value = data;
      
      AIDebugHelper.logStateChange('financingData', oldData, data);
      
      // 触发相关计算
      calculateAmounts();
      
    } catch (e, stackTrace) {
      AIDebugHelper.logError('Failed to update financing data', e,
        stackTrace: stackTrace, context: 'FinancingController.updateFinancingData');
    }
  }
}
```

### 🔍 调试工作流程

#### 步骤1：启用调试
在您的代码中添加调试语句：

```dart
// 在关键函数开始处
AIDebugHelper.logFunctionCall('yourFunctionName', parameters: {...});

// 在状态变化处
AIDebugHelper.logStateChange('stateName', oldValue, newValue);

// 在错误处理处
AIDebugHelper.logError('Error message', error, autoAnalyze: true);
```

#### 步骤2：运行并收集日志
```bash
flutter run --debug
```

在控制台中查看调试输出，或使用：
```dart
// 获取所有调试日志
String logs = AIDebugHelper.getDebugLogs();

// 获取错误日志
String errorLogs = AIDebugHelper.getErrorLogs();
```

#### 步骤3：AI分析
将日志复制给AI进行分析：

```
日志如下：
[2024-01-15T10:30:00.000Z] [ERROR] [ERROR] ERROR: Calculation failed | Context: {"message":"Calculation failed","error":"type 'Null' is not a subtype of type 'double'","context":"calculateAmounts function"}

我看到了这个错误，请帮我分析原因并提供修复建议。
```

#### 步骤4：自动修复
AI会提供修复建议，您可以直接应用：

```dart
// AI建议的修复代码
num? inputAmount = num.tryParse(controller.text);
if (inputAmount == null) {
  AIDebugHelper.logBusinessLogic('Input validation failed', data: {
    'inputText': controller.text,
    'reason': 'invalid_number_format',
  });
  authorizedAmount = 0.0;
  interestAmount = 0.0;
  update();
  return;
}
```

### 🎛️ 调试配置

#### 启用/禁用特定调试功能
编辑 `lib/config/debug_config.dart`：

```dart
class DebugConfig {
  // 启用状态调试
  static const bool enableStateDebug = true;
  
  // 启用网络调试
  static const bool enableNetworkDebug = true;
  
  // 启用性能监控
  static const bool enablePerformanceMonitoring = true;
  
  // 启用自动错误分析
  static const bool enableAutoFix = true;
}
```

#### 设置日志级别
```dart
// 只显示ERROR级别的日志
static const String currentLogLevel = 'ERROR';

// 显示所有DEBUG级别及以上的日志
static const String currentLogLevel = 'DEBUG';
```

### 📊 调试输出示例

#### 正常调试日志
```
[2024-01-15T10:30:00.000Z] [DEBUG] [FUNC] Function Call: calculateAmounts | Context: {"function":"calculateAmounts","parameters":{"inputAmount":1000,"leverage":2.0,"type":"ZJRZ"},"timestamp":"2024-01-15T10:30:00.000Z"}
[2024-01-15T10:30:00.001Z] [DEBUG] [BIZ] Business Logic: TRS Calculation | Context: {"logic":"TRS Calculation","data":{"inputAmount":1000,"leverage":2.0,"originalAmount":5000,"calculationType":"增加TRS"},"category":"financing"}
[2024-01-15T10:30:00.002Z] [DEBUG] [STATE] State Change: authorizedAmount | Context: {"stateName":"authorizedAmount","oldValue":5000,"newValue":7001,"reason":"user_input_change"}
```

#### 错误日志
```
[2024-01-15T10:30:00.000Z] [ERROR] [ERROR] ERROR: Calculation failed | Context: {"message":"Calculation failed","error":"type 'Null' is not a subtype of type 'double'","stackTrace":"#0      calculateAmounts (file:///path/to/file.dart:25:20)","context":"calculateAmounts function","timestamp":"2024-01-15T10:30:00.000Z"}
```

### 🎯 针对您项目的特殊建议

#### 1. 金融计算调试
- 在 `calculateAmounts()` 函数中添加详细的参数和结果日志
- 记录杠杆率、输入金额、计算结果等关键数据
- 监控计算过程中的异常情况

#### 2. 用户操作跟踪
- 记录用户的每个操作步骤
- 跟踪用户在融资流程中的行为
- 分析用户操作模式

#### 3. 网络请求监控
- 监控所有API调用
- 记录请求参数和响应数据
- 跟踪网络错误和超时

#### 4. 状态管理调试
- 记录所有状态变化
- 跟踪数据流向
- 监控状态同步问题

### 🚀 下一步

1. **运行演示**：点击应用中的🐛按钮体验调试功能
2. **集成到现有代码**：在您的业务逻辑中添加调试语句
3. **配置调试级别**：根据开发阶段调整日志级别
4. **AI协作调试**：遇到问题时将日志发送给AI分析

现在您可以在您的Rosun Fi项目中享受AI智能调试的强大功能了！
