import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ==================== 基础组件预览 ====================

/// 简单的文本预览
@Preview(name: '简单文本')
Widget simpleTextPreview() {
  return const Text(
    '你好，世界！',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

/// 按钮预览 - 浅色模式
@Preview(
  name: '主要按钮 - 浅色',
  brightness: Brightness.light,
)
Widget primaryButtonLightPreview() {
  return ElevatedButton(
    onPressed: () {},
    child: const Text('点击我'),
  );
}

/// 按钮预览 - 深色模式
@Preview(
  name: '主要按钮 - 深色',
  brightness: Brightness.dark,
)
Widget primaryButtonDarkPreview() {
  return ElevatedButton(
    onPressed: () {},
    child: const Text('点击我'),
  );
}

/// 卡片预览 - 固定尺寸
@Preview(
  name: '信息卡片',
  size: Size(300, 200),
)
Widget infoCardPreview() {
  return Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '卡片标题',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('这是卡片的内容描述，可以包含多行文字。'),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: const Text('取消')),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: () {}, child: const Text('确认')),
            ],
          ),
        ],
      ),
    ),
  );
}

/// 列表项预览
@Preview(name: '列表项')
Widget listItemPreview() {
  return ListTile(
    leading: const CircleAvatar(
      backgroundColor: Colors.blue,
      child: Icon(Icons.person, color: Colors.white),
    ),
    title: const Text('用户名称'),
    subtitle: const Text('这是副标题信息'),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {},
  );
}

// ==================== 自定义主题预览 ====================

/// 使用自定义主题的预览
@Preview(
  name: '自定义主题按钮',
  // theme: _customTheme,
)
Widget customThemeButtonPreview() {
  return ElevatedButton(
    onPressed: () {},
    child: const Text('自定义主题按钮'),
  );
}

ThemeData _customTheme() {
  return ThemeData(
    primarySwatch: Colors.purple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

// ==================== 包装器预览 ====================

/// 使用包装器添加 Material 和 Scaffold
@Preview(
  name: '完整页面布局',
  wrapper: _materialWrapper,
)
Widget fullPagePreview() {
  return Scaffold(
    appBar: AppBar(
      title: const Text('页面标题'),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 80, color: Colors.green),
          const SizedBox(height: 16),
          const Text(
            '操作成功！',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('您的操作已经完成'),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: const Text('返回首页'),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
  );
}

Widget _materialWrapper(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
}

// ==================== 响应式布局预览 ====================

/// 不同尺寸的预览 - 小
@Preview(
  name: '响应式卡片 - 小',
  size: Size(200, 150),
)
Widget responsiveCardSmallPreview() {
  return _ResponsiveCard();
}

/// 不同尺寸的预览 - 中
@Preview(
  name: '响应式卡片 - 中',
  size: Size(400, 200),
)
Widget responsiveCardMediumPreview() {
  return _ResponsiveCard();
}

/// 不同尺寸的预览 - 大
@Preview(
  name: '响应式卡片 - 大',
  size: Size(600, 300),
)
Widget responsiveCardLargePreview() {
  return _ResponsiveCard();
}

class _ResponsiveCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 300;
          final isMedium = constraints.maxWidth >= 300 && constraints.maxWidth < 500;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSmall ? '小' : (isMedium ? '中' : '大'),
                  style: TextStyle(
                    fontSize: isSmall ? 16 : (isMedium ? 20 : 24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '当前宽度: ${constraints.maxWidth.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==================== 表单组件预览 ====================

/// 输入框预览
@Preview(name: '文本输入框')
Widget textFieldPreview() {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: '用户名',
        hintText: '请输入用户名',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
      ),
    ),
  );
}

/// 开关组件预览
@Preview(name: '开关按钮')
Widget switchPreview() {
  return const SwitchListTile(
    title: Text('接收通知'),
    subtitle: Text('允许应用发送推送通知'),
    value: true,
    onChanged: null, // 预览中使用 null
  );
}

// ==================== 复杂组件预览 ====================

/// 用户资料卡片预览
@Preview(
  name: '用户资料卡片',
  size: Size(350, 400),
  wrapper: _materialWrapper,
)
Widget userProfileCardPreview() {
  return Center(
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              '张三',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'zhangsan@example.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('关注', '128'),
                _buildStatItem('粉丝', '2.5K'),
                _buildStatItem('帖子', '86'),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('关注'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('消息'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStatItem(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(color: Colors.grey),
      ),
    ],
  );
}

