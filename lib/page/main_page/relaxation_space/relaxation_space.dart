import 'package:flutter/material.dart';
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
