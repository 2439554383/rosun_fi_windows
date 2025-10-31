import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' show log;
import '../../../../util/app_component.dart';
import '../../../../network/dio_util.dart';
import '../../../../network/apis.dart';
import '../new_deposit_model.dart';

class NewDepositCtrl extends GetxController {
  // 入金申请相关
  final amountController = TextEditingController();
  final remarkController = TextEditingController();

  // 状态管理
  bool isLoading = false;
  bool isSubmitting = false;

  // 数据列表
  List<NewDepositRequest> depositList = [];
  List<DepositBank> bankList = [];

  // 选中的银行
  DepositBank? selectedBank;

  // 选中的入金方式
  int selectedDepositMethod = 1; // 默认选择国际电汇

  // 选中的币种
  String selectedCurrency = 'HKD';

  // 服务费信息
  ServiceChargeResponse? serviceChargeInfo;

  // 当前页面类型 (0: 入金, 1: 出金)
  int currentTabIndex = 0;

  // 出金相关
  List<NewWithdrawRequest> withdrawList = [];

  @override
  void onInit() {
    super.onInit();
    getDepositList();
    getBankList();
  }

  @override
  void onClose() {
    amountController.dispose();
    remarkController.dispose();
    super.onClose();
  }

  // 切换标签页
  void switchTab(int index) {
    currentTabIndex = index;
    if (index == 0) {
      getDepositList();
    } else {
      getWithdrawList();
    }
    update();
  }

  // 提交入金申请
  void submitDeposit() async {
    log('submitDeposit：开始');
    if (amountController.text.isEmpty) {
      log('submitDeposit：金额为空');
      showToast('请输入入金金额');
      return;
    }

    final amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      log('submitDeposit：金额非法 -> 原始="${amountController.text}" 解析=$amount');
      showToast('请输入有效的入金金额');
      return;
    }

    log('submitDeposit：金额解析成功 = $amount');
    isSubmitting = true;
    log('submitDeposit：isSubmitting=true，调用update()');
    update();

    try {
      // 写死的银行信息
      final fixedBankId = 1; // 固定银行ID
      final fixedBankName = '【中国香港】花旗银行(4546)'; // 固定银行名称
      log('submitDeposit：使用固定银行 -> id=$fixedBankId, 名称=$fixedBankName');

      // 写死的凭证信息（数组格式）
      final fixedTransferProof = [
        'transfer_proof_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ];
      log('submitDeposit：生成转账凭证 -> ${fixedTransferProof.join(', ')}');

      final data = NewDepositRequestData(
        amount: amount,
        bankId: fixedBankId,
        currency: selectedCurrency,
        depositMethod: selectedDepositMethod,
        transferProof: fixedTransferProof,
        remark: remarkController.text.trim(),
      );
      log(
        'submitDeposit：请求载荷就绪 -> 币种=$selectedCurrency, 方式=$selectedDepositMethod, 备注长度=${remarkController.text.trim().length}',
      );

      log('submitDeposit：发起POST -> ${Api.newDepositRequest}');
      final response = await HttpUtil().post(
        Api.newDepositRequest,
        data: data.toJson(),
      );
      log(
        'submitDeposit：响应 -> isSuccess=${response.isSuccess}, message=${response.message}',
      );

      if (response.isSuccess) {
        showSuccessToast('入金申请提交成功');
        log('submitDeposit：成功，清空输入并刷新列表');
        amountController.clear();
        remarkController.clear();
        getDepositList();
        // 跳转到成功页面
        log('submitDeposit：导航至 /newDepositSuccess，携带参数');
        Get.toNamed(
          '/newDepositSuccess',
          arguments: {
            'amount': amount,
            'bank': fixedBankName,
            'serviceCharge': serviceChargeInfo?.serviceCharge ?? 0.0,
            'currency': selectedCurrency,
          },
        );
      } else {
        log('submitDeposit：失败，展示错误提示');
        showErrorToast('${response.message}');
      }
    } catch (e) {
      log('submitDeposit：异常 -> $e');
      showErrorToast('提交失败，请重试');
    } finally {
      isSubmitting = false;
      log('submitDeposit：isSubmitting=false，调用update()');
      update();
    }
  }

  // 获取入金列表
  void getDepositList() async {
    isLoading = true;
    update();

    try {
      final response = await HttpUtil().get(Api.newDepositRequestList);

      if (response.isSuccess) {
        final depositResponse = NewDepositListResponse.fromJson(response.data);
        depositList = depositResponse.data;
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

  // 获取出金列表
  void getWithdrawList() async {
    isLoading = true;
    update();

    try {
      final response = await HttpUtil().get(Api.withdrawRequestList);

      if (response.isSuccess) {
        final withdrawResponse = NewWithdrawListResponse.fromJson(
          response.data,
        );
        withdrawList = withdrawResponse.data;
      } else {
        showToast('${response.message}');
      }
    } catch (e) {
      showToast('获取出金列表失败');
    } finally {
      isLoading = false;
      update();
    }
  }

  // 获取银行列表
  void getBankList() async {
    try {
      final response = await HttpUtil().get(Api.newDepositBankList);

      if (response.isSuccess) {
        final bankResponse = DepositBankListResponse.fromJson(response.data);
        bankList = bankResponse.data;
      } else {
        showToast('${response.message}');
      }
    } catch (e) {
      showToast('获取银行列表失败');
    }
  }

  // 查询服务费
  void getServiceCharge() async {
    if (amountController.text.isEmpty) return;

    final amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) return;

    try {
      final response = await HttpUtil().get(
        '${Api.newDepositServiceCharge}?amount=$amount&currency=$selectedCurrency&type=1',
      );

      if (response.isSuccess) {
        serviceChargeInfo = ServiceChargeResponse.fromJson(response.data);
        update();
      }
    } catch (e) {
      // 静默处理服务费查询失败
    }
  }

  // 选择银行
  void selectBank(DepositBank bank) {
    selectedBank = bank;
    update();
  }

  // 选择入金方式
  void selectDepositMethod(int method) {
    selectedDepositMethod = method;
    update();
  }

  // 选择币种
  void selectCurrency(String currency) {
    selectedCurrency = currency;
    update();
  }

  // 刷新入金列表
  void refreshDepositList() {
    getDepositList();
  }

  // 刷新出金列表
  void refreshWithdrawList() {
    getWithdrawList();
  }

  // 获取入金方式选项
  List<Map<String, dynamic>> get depositMethodOptions => [
    {'value': 1, 'text': '存入国际电汇'},
    {'value': 2, 'text': '存入稳定币'},
    {'value': 3, 'text': '存入BTC'},
  ];

  // 获取币种选项
  List<String> get currencyOptions => ['CNY', 'HKD', 'USD'];

  // 获取状态颜色
  Color getStatusColor(int? status) {
    switch (status) {
      case 0:
        return const Color(0xFFFF9800); // 待审核/进行中 - 橙色
      case 1:
        return const Color(0xFF4CAF50); // 已完成 - 绿色
      case 2:
        return const Color(0xFFF44336); // 交易失败 - 红色
      default:
        return const Color(0xFF666666); // 默认 - 灰色
    }
  }
}
