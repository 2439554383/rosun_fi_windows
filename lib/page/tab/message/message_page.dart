import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'message_ctrl.dart';

class MessagePage extends GetView<MessageCtrl> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<MessageCtrl>(
      init: MessageCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(pW),
                Expanded(child: _buildMessageContent(pW, controller)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(PublicWidget pW) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            '消息',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.mark_email_read)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget _buildMessageContent(PublicWidget pW, MessageCtrl controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildMessageCategories(pW, controller),
          pW.Box(h: 16.h),
          Expanded(child: _buildMessageList(pW, controller)),
        ],
      ),
    );
  }

  Widget _buildMessageCategories(PublicWidget pW, MessageCtrl controller) {
    return Container(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          final isSelected = controller.selectedCategory == index;
          return Container(
            margin: EdgeInsets.only(right: 8.w),
            child: ElevatedButton(
              onPressed: () => controller.selectCategory(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
                foregroundColor: isSelected ? Colors.white : Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text(category),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageList(PublicWidget pW, MessageCtrl controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: controller.getMessageList().length,
        itemBuilder: (context, index) {
          final message = controller.getMessageList()[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: message['isRead']
                  ? Colors.grey[300]
                  : Colors.blue,
              child: Icon(
                message['type'] == 'system'
                    ? Icons.settings
                    : Icons.notifications,
                color: message['isRead'] ? Colors.grey[600] : Colors.white,
              ),
            ),
            title: Text(
              message['title'],
              style: TextStyle(
                fontWeight: message['isRead']
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
            subtitle: Text(
              message['content'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!message['isRead'])
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                pW.Box(h: 4.h),
                Text(
                  message['time'],
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ],
            ),
            onTap: () => controller.readMessage(index),
          );
        },
      ),
    );
  }
}
