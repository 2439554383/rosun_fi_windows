import 'package:flutter/foundation.dart' show kIsWeb;

// 条件导入 Platform：Web 平台导入 stub，非 Web 平台导入 dart:io
import 'dart:io' if (dart.library.html) 'platform_stub.dart' as io;

/// 平台检测工具类
class PlatformUtil {
  /// 检测是否为 Windows 平台
  static bool get isWindows {
    if (kIsWeb) {
      return false;
    }
    // ignore: undefined_prefixed_name
    return io.Platform.isWindows;
  }
}

