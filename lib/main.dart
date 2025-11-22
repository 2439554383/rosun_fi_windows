import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/config/windows_config.dart';
import 'package:rosun_fi_windows/page/start_page/start_page.dart';
import 'package:rosun_fi_windows/util/f_route.dart';
import 'package:rosun_fi_windows/util/platform_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 根据平台获取设计尺寸
  Size get _designSize {
    if (PlatformUtil.isWindows) {
      return const Size(1920, 1080); // Windows端设计尺寸
    } else {
      return const Size(375, 812); // 移动端设计尺寸 (iPhone X尺寸)
    }
  }

  // 根据平台获取字体
  String? get _fontFamily {
    if (PlatformUtil.isWindows) {
      return 'Microsoft YaHei'; // Windows端字体
    } else {
      return null; // 移动端使用系统默认字体
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Rosun FI Windows',
          debugShowCheckedModeBanner: false,
          getPages: FRoute.getPages,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: WindowsConfig.primaryColor,
            scaffoldBackgroundColor: WindowsConfig.backgroundColor,
            cardColor: WindowsConfig.cardColor,
            fontFamily: _fontFamily,
            textTheme: TextTheme(
              headlineLarge: WindowsConfig.titleTextStyle,
              bodyLarge: WindowsConfig.bodyTextStyle,
              bodyMedium: WindowsConfig.hintTextStyle,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: WindowsConfig.primaryButtonStyle,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(WindowsConfig.smallRadius),
                borderSide: const BorderSide(color: WindowsConfig.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(WindowsConfig.smallRadius),
                borderSide: const BorderSide(color: WindowsConfig.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(WindowsConfig.smallRadius),
                borderSide: const BorderSide(color: WindowsConfig.primaryColor),
              ),
            ),
          ),
          home: const StartPage(),
        );
      },
    );
  }
}
