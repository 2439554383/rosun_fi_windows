import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import '../../../../util/app_component.dart';

class ToastTestPage extends StatelessWidget {
  const ToastTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Windows提示测试'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF333333),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Windows 提示方式测试',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
              ),
            ),
            pW.Box(h: 20.h),

            // 基础提示
            _buildSectionTitle('基础提示'),
            _buildButton('普通提示', () => showToast('这是一个普通提示')),
            _buildButton('信息提示', () => showInfoToast('这是一个信息提示')),
            _buildButton('成功提示', () => showSuccessToast('操作成功！')),
            _buildButton('警告提示', () => showWarningToast('请注意这个警告')),
            _buildButton('错误提示', () => showErrorToast('操作失败，请重试')),

            pW.Box(h: 20.h),

            // 入金相关提示
            _buildSectionTitle('入金功能提示'),
            _buildButton('入金申请成功', () => showSuccessToast('入金申请提交成功')),
            _buildButton('银行选择提示', () => showInfoToast('请选择入金银行')),
            _buildButton('金额输入提示', () => showWarningToast('请输入有效的入金金额')),
            _buildButton('网络错误', () => showErrorToast('网络连接失败，请检查网络')),

            pW.Box(h: 20.h),

            // 说明文字
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFF2196F3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Windows平台提示说明：',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1976D2),
                    ),
                  ),
                  pW.Box(h: 8.h),
                  Text(
                    '• 使用GetX的SnackBar作为提示方式\n'
                    '• 支持不同类型的提示（成功、错误、警告、信息）\n'
                    '• 自动适配Windows平台\n'
                    '• 其他平台仍使用原来的Toast方式',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF1976D2),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
