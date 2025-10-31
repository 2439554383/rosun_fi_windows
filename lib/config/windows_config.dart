import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WindowsConfig {
  // Windows端适配配置
  static const double minWindowWidth = 1200.0;
  static const double minWindowHeight = 800.0;

  // 字体大小配置
  static const double baseFontSize = 12.0;
  static const double titleFontSize = 16.0;
  static const double largeFontSize = 24.0;

  // 间距配置
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;

  // 颜色配置
  static const Color primaryColor = Color(0xFF1976D2);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF6C757D);
  static const Color borderColor = Color(0xFFE9ECEF);

  // 圆角配置
  static const double smallRadius = 4.0;
  static const double mediumRadius = 8.0;
  static const double largeRadius = 12.0;

  // 阴影配置
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      spreadRadius: 0,
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  // 按钮样式配置
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(smallRadius.r),
    ),
  );

  static ButtonStyle get secondaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFF8F9FA),
    foregroundColor: textHint,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(smallRadius.r),
      side: const BorderSide(color: borderColor),
    ),
  );

  // 文本样式配置
  static TextStyle get titleTextStyle => TextStyle(
    fontSize: titleFontSize.sp,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get bodyTextStyle => TextStyle(
    fontSize: baseFontSize.sp,
    color: textSecondary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get hintTextStyle => TextStyle(
    fontSize: baseFontSize.sp,
    color: textHint,
    fontWeight: FontWeight.w400,
  );

  // 输入框样式配置
  static InputDecoration get inputDecoration => InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(smallRadius.r),
      borderSide: const BorderSide(color: borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(smallRadius.r),
      borderSide: const BorderSide(color: borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(smallRadius.r),
      borderSide: const BorderSide(color: primaryColor),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
  );
}
