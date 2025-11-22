import 'package:get/get.dart';
import 'package:rosun_fi_windows/util/app_component.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' show log;

class RelaxationSpaceCtrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
    log("RelaxationSpaceCtrl初始化");
  }

  @override
  void onClose() {
    log("RelaxationSpaceCtrl销毁");
    super.onClose();
  }

  void pageFocus() {
    log("聚焦RelaxationSpaceCtrl");
  }

  void pageUnFocus() {
    log("失焦RelaxationSpaceCtrl");
  }

  Future<void> openQuickApp(String url) async {
    bool launchSuccess = false;
    List<String> urlsToTry = [];
    String? lastError;

    // 解析原始 URL，提取应用标识
    final originalUri = Uri.parse(url);
    String? appId;
    if (originalUri.scheme == 'hap' && originalUri.host == 'app') {
      // hap://app/com.ctrip.QUICKAPP -> com.ctrip.QUICKAPP
      final pathSegments = originalUri.pathSegments;
      if (pathSegments.isNotEmpty) {
        appId = pathSegments.first;
      }
    }

    // 构建多种可能的 URL 格式
    if (appId != null) {
      // 1. 原始 hap:// 格式
      urlsToTry.add(url);
      // 2. 尝试 hwfastapp:// 格式（华为快应用）
      urlsToTry.add("hwfastapp://app/$appId");
      // 3. 尝试携程应用包名直接启动
      urlsToTry.add("ctrip://www.ctrip.com");
    } else {
      urlsToTry.add(url);
    }

    // 依次尝试不同的 URL
    for (final urlToTry in urlsToTry) {
      if (launchSuccess) break;

      try {
        final uri = Uri.parse(urlToTry);
        log("尝试打开快应用: $urlToTry");

        // 先检查是否可以启动
        final canLaunch = await canLaunchUrl(uri);
        log("canLaunchUrl($urlToTry) = $canLaunch");

        if (canLaunch) {
          try {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
            launchSuccess = true;
            log("成功启动快应用: $urlToTry");
            showToast('正在打开携程快应用...');
            break;
          } catch (e) {
            lastError = e.toString();
            log("启动快应用失败: $e");
          }
        } else {
          // 即使 canLaunchUrl 返回 false，也尝试启动（某些情况下检查不准确）
          try {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
            launchSuccess = true;
            log("强制启动成功（canLaunchUrl返回false但启动成功）: $urlToTry");
            showToast('正在打开携程快应用...');
            break;
          } catch (e) {
            lastError = e.toString();
            log("强制启动失败: $e");
          }
        }
      } catch (e) {
        lastError = e.toString();
        log("打开 $urlToTry 异常: $e");
        continue;
      }
    }

    // 如果所有快应用 URL 都失败，尝试降级方案
    if (!launchSuccess) {
      log("所有快应用启动方式都失败，最后错误: $lastError");
      log("尝试打开携程网页版（外部浏览器）");
      
      // 尝试打开携程网页版（必须在外部浏览器打开）
      try {
        final webUri = Uri.parse("https://m.ctrip.com");
        
        // 强制使用外部浏览器打开
        if (await canLaunchUrl(webUri)) {
          await launchUrl(
            webUri,
            mode: LaunchMode.externalApplication,
          );
          showToast('快应用不可用，已打开携程网页版');
        } else {
          // 如果无法打开，尝试使用系统默认浏览器
          await launchUrl(
            webUri,
            mode: LaunchMode.platformDefault,
          );
          showToast('快应用不可用，已打开携程网页版');
        }
      } catch (e) {
        log("打开网页版失败: $e");
        showToast('无法打开快应用，请检查是否已安装携程应用或快应用引擎');
      }
    }
  }
}

