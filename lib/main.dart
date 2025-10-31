import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/page/tab/tab.dart';
import 'package:rosun_fi_windows/config/windows_config.dart';
import 'package:rosun_fi_windows/util/f_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // Windows端设计尺寸
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
            fontFamily: 'Microsoft YaHei', // Windows端字体
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
          home: const TabPage(),
        );
      },
    );
  }
}
