import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:genui/genui.dart';
import 'package:genui_firebase_ai/genui_firebase_ai.dart';
import 'package:genui_google_generative_ai/genui_google_generative_ai.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'relaxation_space_ctrl.dart';

class RelaxationSpace extends StatefulWidget {
  const RelaxationSpace({super.key});

  @override
  State<RelaxationSpace> createState() => _RelaxationSpaceState();
}

class _RelaxationSpaceState extends State<RelaxationSpace> with TickerProviderStateMixin {
  late final GenUiManager _genUiManager;
  late final GenUiConversation _genUiConversation;
  late AnimationController _glowController;
  
  final _textController = TextEditingController();
  final _surfaceIds = <String>[];
  final catalog = CoreCatalogItems.asCatalog();
  
  bool _isLoading = false; // 加载状态

  @override
  void initState() {
    super.initState();
    
    // 发光动画控制器
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    print("🚀 [初始化] 开始初始化 GenUI");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

    // Create a GenUiManager with a widget catalog.
    _genUiManager = GenUiManager(catalog: catalog);
    print("✅ [初始化] GenUiManager 创建成功");

    // Create a ContentGenerator to communicate with the LLM.
    final contentGenerator = GoogleGenerativeAiContentGenerator(
      systemInstruction: '''
    # 你是一个极具创造力的 Flutter 交互式应用生成器 AI

## 🎯 核心使命
无论用户输入什么需求，你都必须生成一个**完整、可交互、实用**的 Flutter UI 组件或小应用。
不要预设任何限制，充分发挥创造力！

## 💡 设计原则

### 1. 完整性
- 生成的必须是一个完整的、可以直接使用的应用
- 包含所有必要的元素（标题、内容、操作按钮等）
- 不要生成残缺或示例性的界面

### 2. 可交互性
- **必须包含可交互元素**：按钮、输入框、选择器、滑块等
- 按钮必须有明确的功能说明（点击后会发生什么）
- 如果是表单，要有提交按钮
- 如果是计数器，要有增加/减少按钮
- 如果是列表，要有可点击的项目

### 3. 实用性
- 根据用户输入理解真实的使用场景
- 生成实际有用的功能
- 添加合理的默认数据和示例内容

### 4. 美观性
- 使用合理的颜色搭配
- 适当的间距和边距
- 清晰的层次结构
- 现代化的 UI 设计

## 🎨 生成策略

### 根据输入类型智能生成

#### 1. 工具类应用
用户输入："计算器"、"倒计时"、"单位转换"
→ 生成完整的功能性工具，带输入、计算逻辑、结果显示

#### 2. 信息展示类
用户输入："天气"、"新闻卡片"、"个人资料"
→ 生成信息丰富的展示界面，带图标、数据、状态

#### 3. 表单类
用户输入："登录"、"注册"、"反馈表单"
→ 生成完整表单，包含输入框、验证提示、提交按钮

#### 4. 列表类
用户输入："任务列表"、"购物车"、"聊天记录"
→ 生成可滚动列表，带操作按钮（删除、编辑、完成）

#### 5. 游戏/娱乐类
用户输入："抽奖"、"猜数字"、"翻牌游戏"
→ 生成互动游戏界面，带游戏逻辑和反馈

#### 6. 数据可视化类
用户输入："统计面板"、"进度追踪"、"仪表盘"
→ 生成数据展示界面，带进度条、图表样式、数字

#### 7. 创意类
用户输入任何创意想法
→ 发挥想象力，生成最合适的交互式应用

## ⚡ 关键要求

### 必须做到：
✅ 每个生成的界面都要有至少 1-2 个可交互元素（按钮、输入框等）
✅ 按钮要有清晰的文字说明功能
✅ 使用 Column 作为根组件组织结构
✅ 合理使用 Card 组件包装内容
✅ 添加适当的图标增强视觉效果
✅ 使用 Markdown 展示丰富的文本内容
✅ 添加分隔线和间距优化布局
✅ 给出示例数据让界面更生动
✅ 界面是完全可交互的，比如添加添加，记录就会增加并显示等等
### 绝对不要：
❌ 生成空壳界面（只有标题没有内容）
❌ 生成纯文字说明（必须是实际 UI）
❌ 生成不完整的组件
❌ 忽略用户的核心需求

## 🌟 创意示例

### 例子 1：计算器
生成：数字按钮网格 + 运算符按钮 + 结果显示区 + 清除按钮

### 例子 2：番茄钟
生成：倒计时显示 + 开始/暂停按钮 + 重置按钮 + 设置按钮

### 例子 3：待办清单
生成：任务输入框 + 添加按钮 + 任务列表（带完成/删除按钮）

### 例子 4：体重记录器
生成：当前体重显示 + 输入框 + 记录按钮 + 历史记录列表

### 例子 5：随机决策器
生成：选项输入区 + 开始按钮 + 动画结果显示 + 历史记录

## 🎯 最终目标

用户输入任何内容后，你要：
1. **理解意图**：用户想要什么功能
2. **设计交互**：用户如何使用这个应用
3. **实现功能**：通过 UI 组件实现完整流程
4. **优化体验**：让界面美观、易用、有趣

**记住：你的目标是生成一个用户可以立即使用的完整小应用，而不是一个演示或原型！**

现在，发挥你的创造力，根据用户输入生成最合适的交互式应用吧！🚀
        ''',
      catalog: catalog,
      apiKey:"AIzaSyDJfyGbOam5oLWDr9xKidJH1A7ABokDG6Q"
    );
    print("✅ [初始化] FirebaseAiContentGenerator 创建成功");

    // Create the GenUiConversation to orchestrate everything.
    _genUiConversation = GenUiConversation(
      genUiManager: _genUiManager,
      contentGenerator: contentGenerator,
      onSurfaceAdded: _onSurfaceAdded,
      onSurfaceDeleted: _onSurfaceDeleted,
    );
    print("✅ [初始化] GenUiConversation 创建成功");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    print("✨ 初始化完成！系统已就绪");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");
  }

  // A callback invoked by the [GenUiConversation] when a new UI surface is generated.
  void _onSurfaceAdded(SurfaceAdded update) {
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    print("➕ [回调] Surface 已添加");
    print("   Surface ID: ${update.surfaceId}");
    print("   当前 Surface 总数: ${_surfaceIds.length + 1}");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");
    
    setState(() {
      _surfaceIds.add(update.surfaceId);
      _isLoading = false; // 收到响应，停止加载
    });
  }

  // A callback invoked by GenUiConversation when a UI surface is removed.
  void _onSurfaceDeleted(SurfaceRemoved update) {
    print("❌ [回调] Surface 已删除: ${update.surfaceId}\n");
    setState(() {
      _surfaceIds.remove(update.surfaceId);
    });
  }

  // Send a message containing the user's text to the agent.
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    print("📤 [发送] 用户发送消息");
    print("   内容: $text");
    print("   时间: ${DateTime.now().toString()}");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    
    setState(() {
      _isLoading = true; // 开始加载
    });
    
    _genUiConversation.sendRequest(UserMessage.text(text));
    print("✅ [发送] 消息已发送到 AI");
    print("⏳ [等待] 等待 AI 响应...\n");
  }

  @override
  void dispose() {
    _textController.dispose();
    _genUiConversation.dispose();
    _glowController.dispose();
    print("👋 RelaxationSpace 已销毁\n");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<RelaxationSpaceCtrl>(
      init: RelaxationSpaceCtrl(),
      builder: (ctrl) {
        return FocusDetector(
          onFocusGained: ctrl.pageFocus,
          onFocusLost: ctrl.pageUnFocus,
          child: Scaffold(
            backgroundColor: const Color(0xFF0A0A0A), // 深黑背景
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0A0A0A),
                    const Color(0xFF1A1A1A),
                    const Color(0xFF0A0A0A),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildHeader(),
                          if (_isLoading) _buildLoadingBar(),
                          if (_surfaceIds.isEmpty)
                            _buildEmptyState()
                          else
                            _buildSurfaceList(),
                        ],
                      ),
                    ),
                    _buildInputBar(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // 顶部标题栏 - 科技感设计
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.1),
            Colors.blue.withOpacity(0.1),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.purple.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // 发光图标
          AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(_glowController.value * 0.6),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.psychology_outlined,
                  color: Colors.purple.shade300,
                  size: 32.sp,
                ),
              );
            },
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '心宁 AI',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'Relaxation Assistant',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade500,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Spacer(),
          // 状态指示器
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.green.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  'ONLINE',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 加载状态栏
  Widget _buildLoadingBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.2),
            Colors.blue.withOpacity(0.2),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.purple.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.purple.shade300),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'AI 正在生成中...',
            style: TextStyle(
              color: Colors.purple.shade300,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  // Surface 列表
  Widget _buildSurfaceList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: List.generate(_surfaceIds.length, (index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 400 + (index * 100)),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.withOpacity(0.15),
                    Colors.blue.withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.purple.withOpacity(0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: GenUiSurface(
                host: _genUiConversation.host,
                surfaceId: _surfaceIds[index],
              ),
            ),
          );
        }),
      ),
    );
  }

  // 空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.purple.withOpacity(_glowController.value * 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.spa_outlined,
                  size: 100.sp,
                  color: Colors.purple.shade300,
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          Text(
            '欢迎来到放松空间',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            '输入任何词语，AI 将为你生成有趣的内容',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 32.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            children: ['cat', 'sunshine', 'music', 'dream'].map((word) {
              return InkWell(
                onTap: () {
                  _textController.text = word;
                  _sendMessage(word);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.3),
                        Colors.blue.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: Colors.purple.withOpacity(0.6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 输入栏
  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.5),
        border: Border(
          top: BorderSide(
            color: Colors.purple.withOpacity(0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(28.r),
                border: Border.all(
                  color: _isLoading 
                      ? Colors.purple.withOpacity(0.6)
                      : Colors.purple.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: TextField(
                controller: _textController,
                enabled: !_isLoading,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: _isLoading ? '正在处理中...' : '输入你的想法...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  prefixIcon:Icon(
                          Icons.edit_outlined,
                          color: Colors.purple.shade300,
                          size: 20.sp,
                        ),
                ),
                onSubmitted: _isLoading ? null : (value) {
                  _sendMessage(value);
                  _textController.clear();
                },
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // 发送按钮
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              gradient: _isLoading
                  ? LinearGradient(colors: [Colors.grey.shade700, Colors.grey.shade800])
                  : LinearGradient(colors: [Colors.purple.shade600, Colors.blue.shade600]),
              shape: BoxShape.circle,
              boxShadow: _isLoading ? [] : [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _isLoading ? null : () {
                  _sendMessage(_textController.text);
                  _textController.clear();
                },
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: _isLoading
                      ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: const AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
