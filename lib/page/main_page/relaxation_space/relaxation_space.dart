import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:genui/genui.dart';
import 'package:genui_firebase_ai/genui_firebase_ai.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/util/f_route.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'relaxation_space_ctrl.dart';

class RelaxationSpace extends StatefulWidget {

  const RelaxationSpace({super.key});

  @override
  State<RelaxationSpace> createState() => _RelaxationSpaceState();
}

class _RelaxationSpaceState extends State<RelaxationSpace> {
  late final GenUiManager _genUiManager;
  late final GenUiConversation _genUiConversation;
  final _textController = TextEditingController();
  final _surfaceIds = <String>[];

  // Send a message containing the user's text to the agent.
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _genUiConversation.sendRequest(UserMessage.text(text));
  }

  // A callback invoked by the [GenUiConversation] when a new UI surface is generated.
  // Here, the ID is stored so the build method can create a GenUiSurface to
  // display it.
  void _onSurfaceAdded(SurfaceAdded update) {
    setState(() {
      _surfaceIds.add(update.surfaceId);
    });
  }

  // A callback invoked by GenUiConversation when a UI surface is removed.
  void _onSurfaceDeleted(SurfaceRemoved update) {
    setState(() {
      _surfaceIds.remove(update.surfaceId);
    });
  }



  @override
  void initState() {

    // Create a GenUiManager with a widget catalog.
    // The CoreCatalogItems contain basic widgets for text, markdown, and images.
    _genUiManager = GenUiManager(catalog: CoreCatalogItems.asCatalog());

    // Create a ContentGenerator to communicate with the LLM.
    // Provide system instructions and the catalog from the GenUiManager.
    final contentGenerator = FirebaseAiContentGenerator(
      systemInstruction: '''
        You are an expert in creating funny riddles. Every time I give you a word,
        you should generate UI that displays one new riddle related to that word.
        Each riddle should have both a question and an answer.
        ''',
      catalog: CoreCatalogItems.asCatalog(),
    );

    // Create the GenUiConversation to orchestrate everything.
    _genUiConversation = GenUiConversation(
      genUiManager: _genUiManager,
      contentGenerator: contentGenerator,
      onSurfaceAdded: _onSurfaceAdded, // Added in the next step.
      onSurfaceDeleted: _onSurfaceDeleted, // Added in the next step.
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _genUiConversation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<RelaxationSpaceCtrl>(
      init: RelaxationSpaceCtrl(),
      builder: (ctrl) {
        return FocusDetector(
          onFocusGained: () {
            ctrl.pageFocus();
          },
          onFocusLost: () {
            ctrl.pageUnFocus();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pW.Box(h: 30.h),
                    // 在这里添加你的组件内容
                    ElevatedButton(
                        onPressed: () async {
                          ctrl.openQuickApp("hap://app/com.ctrip.QUICKAPP");
                          // FRoute.push(FRoute.spirit);
                        },
                        child: Text("打开快应用")
                    ),
                    Text(
                      '放松空间',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    pW.Box(h: 20.h),
                    Text(
                      '冥想音乐、自然白噪音、助眠故事，治愈你的心灵',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _surfaceIds.length,
                        itemBuilder: (context, index) {
                          // For each surface, create a GenUiSurface to display it.
                          final id = _surfaceIds[index];
                          return GenUiSurface(host: _genUiConversation.host, surfaceId: id);
                        },
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter a message',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Send the user's text to the agent.
                                _sendMessage(_textController.text);
                                _textController.clear();
                              },
                              child: const Text('Send'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==================== Widget Previews ====================

/// 放松空间标题预览
@Preview(name: '放松空间 - 标题部分')
Widget relaxationSpaceTitlePreview() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '放松空间',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          '冥想音乐、自然白噪音、助眠故事，治愈你的心灵',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

/// 放松空间按钮预览
@Preview(name: '放松空间 - 快应用按钮')
Widget relaxationSpaceButtonPreview() {
  return ElevatedButton(
    onPressed: () {},
    child: const Text("打开快应用"),
  );
}

/// 放松空间输入框预览
@Preview(
  name: '放松空间 - 消息输入框',
  size: Size(400, 100),
)
Widget relaxationSpaceInputPreview() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter a message',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Send'),
        ),
      ],
    ),
  );
}

/// 放松空间完整布局预览（简化版，不包含 GetX 和复杂状态）
@Preview(
  name: '放松空间 - 完整布局预览',
  wrapper: _materialAppWrapper,
  size: Size(400, 600),
)
Widget relaxationSpaceLayoutPreview() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: const Text("打开快应用"),
            ),
            const Text(
              '放松空间',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '冥想音乐、自然白噪音、助眠故事，治愈你的心灵',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter a message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _materialAppWrapper(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
}
