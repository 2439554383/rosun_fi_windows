import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' show log;

void showPicker<T>(List<T> pickerData, Function(List<T> selecteds) confirm) {
  FocusManager.instance.primaryFocus?.unfocus();
  final picker = Picker(
    height: 200,
    confirmText: '确定',
    cancelText: '取消',
    adapter: PickerDataAdapter<T>(pickerData: pickerData),
    changeToFirst: false,
    textAlign: TextAlign.left,
    cancelTextStyle: TextStyle(fontSize: 16.sp, color: const Color(0xff999999)),
    confirmTextStyle: TextStyle(
      fontSize: 16.sp,
      color: const Color(0xff304FFF),
      fontWeight: FontWeight.w500,
    ),
    textStyle: TextStyle(color: const Color(0xff999999), fontSize: 16.sp),
    selectedTextStyle: TextStyle(
      color: const Color(0xff2B2B2B),
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    ),
    columnPadding: const EdgeInsets.all(8.0),
    onConfirm: (Picker picker, List value) {
      log('选择：${picker.getSelectedValues()}');
      confirm(picker.getSelectedValues() as List<T>);
    },
  );
  picker.showModal(Get.context!);
}

void showToast(String? m) {
  if (GetPlatform.isWindows) {
  } else {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: m ?? '',
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
    );
  }
}

enum ToastType { success, error, warning, info }

void showWindowsToast(String message, {ToastType type = ToastType.info}) {
  if (GetPlatform.isWindows) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case ToastType.success:
        backgroundColor = const Color(0xFF4CAF50);
        icon = Icons.check_circle;
        break;
      case ToastType.error:
        backgroundColor = const Color(0xFFF44336);
        icon = Icons.error;
        break;
      case ToastType.warning:
        backgroundColor = const Color(0xFFFF9800);
        icon = Icons.warning;
        break;
      case ToastType.info:
        backgroundColor = const Color(0xFF2196F3);
        icon = Icons.info;
        break;
    }

    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      icon: Icon(icon, color: Colors.white, size: 20),
      shouldIconPulse: false,
    );
  } else {
    showToast(message);
  }
}

void showSuccessToast(String message) {
  showWindowsToast(message, type: ToastType.success);
}

void showErrorToast(String message) {
  showWindowsToast(message, type: ToastType.error);
}

void showWarningToast(String message) {
  showWindowsToast(message, type: ToastType.warning);
}

void showInfoToast(String message) {
  showWindowsToast(message, type: ToastType.info);
}

void showT(BuildContext context, String? m) {
  // 已废弃，使用showToast替代
  showToast(m);
}

void showKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<bool> checkStoragePermission({String type = 'image'}) async {
  try {
    Permission primaryPermission;

    switch (type) {
      case 'image':
        primaryPermission = Permission.photos;
        break;
      case 'video':
        primaryPermission = Permission.videos;
        break;
      case 'audio':
        primaryPermission = Permission.audio;
        break;
      default:
        primaryPermission = Permission.photos;
    }

    log('检查存储权限，类型: $type');

    PermissionStatus primaryStatus = await primaryPermission.status;
    log('主权限状态: $primaryStatus');

    if (primaryStatus.isGranted) {
      log('主权限已授予');
      return true;
    }

    PermissionStatus storageStatus = await Permission.storage.status;
    log('Storage权限状态: $storageStatus');

    if (storageStatus.isGranted) {
      log('Storage权限已授予');
      return true;
    }

    if (!primaryStatus.isPermanentlyDenied) {
      log('请求主权限...');
      primaryStatus = await primaryPermission.request();
      log('主权限请求结果: $primaryStatus');

      if (primaryStatus.isGranted) {
        log('主权限已授予');
        return true;
      }
    }

    if (!storageStatus.isPermanentlyDenied) {
      log('请求storage权限...');
      storageStatus = await Permission.storage.request();
      log('Storage权限请求结果: $storageStatus');

      if (storageStatus.isGranted) {
        log('Storage权限已授予');
        return true;
      }
    }

    log('所有权限请求都失败');

    final isPermanentlyDenied =
        primaryStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied;

    if (isPermanentlyDenied) {
      showToast('需要存储权限才能保存文件，请在设置中授予权限');
      await Future.delayed(const Duration(milliseconds: 500));
      openAppSettings();
    } else {
      showToast('需要存储权限才能保存文件');
    }

    return false;
  } catch (e) {
    log('权限检查异常，使用storage权限: $e');
    return checkPermission(Permission.storage);
  }
}

Widget assetImage(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/image/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

Widget assetEnquiry(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/enquiry/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

Widget loginImage(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/login/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

Widget tabImage(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/tab/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

Widget tradeImage(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/trade/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

Widget contractImage(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/contract/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

Widget assetAssetImage(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/asset/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

Widget goldImage(
  String image, {
  double? w,
  double? h,
  BoxFit? fit,
  String format = '.png',
  Color? color,
}) {
  return Image.asset(
    'assets/gold/$image$format',
    width: w,
    height: h,
    fit: fit,
    color: color,
  );
}

snackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(title), duration: Duration(seconds: 1)),
  );
}

appPrint(String data) {
  debugPrint(data);
}

/// 权限检查

Future<bool> checkPermission(Permission permission) async {
  PermissionStatus status = await permission.status;
  if (status.isGranted) {
    return true;
  }
  PermissionStatus _status = await permission.request();
  if (_status.isGranted) {
    return true;
  } else {
    appPrint('checkPermission = ${permission.toString()}');
    showToast('权限被拒绝');
  }
  if (!status.isGranted) {
    openAppSettings();
  }
  return Future.value(false);
}

String getRandomId() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

void appCopy(String? text) {
  Clipboard.setData(ClipboardData(text: text ?? ''));
  showToast('已复制');
}

void safeBack() {
  try {
    // 尝试关闭Snackbar，如果失败则忽略
    try {
      Get.closeAllSnackbars();
    } catch (e) {
      // 忽略关闭Snackbar的错误
    }
    // 返回上一页
    final context = Get.context;
    if (context != null && Navigator.canPop(context)) {
      Navigator.pop(context);
    } else if (Get.context != null) {
      // 使用Get.back()作为后备
      Get.back();
    }
  } catch (e) {
    // 如果所有方法都失败，记录错误但不崩溃
    debugPrint('页面返回失败: $e');
  }
}

Future<void> callPhone(String? phone) async {
  final url = 'tel:${phone ?? ''}';
  final uri = Uri.tryParse(url.trimLeft());
  if (uri != null) {
    final ok = await canLaunchUrl(uri);
    if (ok) {
      launchUrl(uri);
    } else {
      showToast('异常，不能拨打电话');
    }
  }
}
