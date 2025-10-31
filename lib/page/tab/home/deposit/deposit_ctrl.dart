import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/app_component.dart';
import '../../../../network/dio_util.dart';
import '../../../../network/apis.dart';
import '../deposit_model.dart';

class DepositCtrl extends GetxController {
  final amountController = TextEditingController();
  final remarkController = TextEditingController();

  List<Map<String, dynamic>> depositList = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getDepositList();
  }

  @override
  void onClose() {
    amountController.dispose();
    remarkController.dispose();
    super.onClose();
  }

  // 提交入金申请
  void submitDeposit() async {
    if (amountController.text.isEmpty) {
      showToast('请输入入金金额');
      return;
    }

    final amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      showToast('请输入有效的入金金额');
      return;
    }

    try {
      final data = {'amount': amount, 'remark': remarkController.text.trim()};

      final response = await HttpUtil().post(
        Api.depositApplication,
        data: data,
      );

      if (response.isSuccess) {
        showToast('入金申请提交成功');
        amountController.clear();
        remarkController.clear();
        getDepositList(); // 刷新列表
      } else {
        showToast('${response.message}');
      }
    } catch (e) {
      showToast('提交失败，请重试');
    }
  }

  // 获取入金列表
  void getDepositList() async {
    isLoading = true;
    update();

    try {
      final response = await HttpUtil().get(Api.depositList);

      if (response.isSuccess) {
        final depositResponse = DepositListResponse.fromJson(response.data);
        depositList = depositResponse.data
            .map(
              (deposit) => {
                'id': deposit.id,
                'amount': deposit.amount.toString(),
                'status': deposit.status,
                'remark': deposit.remark,
                'createTime': deposit.createTime,
              },
            )
            .toList();
      } else {
        showToast('${response.message}');
      }
    } catch (e) {
      showToast('获取入金列表失败');
    } finally {
      isLoading = false;
      update();
    }
  }

  // 刷新入金列表
  void refreshDepositList() {
    getDepositList();
  }
}
