// 新入金数据模型
class NewDepositRequest {
  final int? id;
  final String? accountNo;
  final int? accountType;
  final double amount;
  final String? applyTime;
  final String? auditRemark;
  final int? auditStatus; // 0-待审核,1-审核通过,2-审核失败
  final String? auditTime;
  final String? bankAccount;
  final String? bankCode;
  final int? bankId;
  final String? bankName;
  final String? bankRegion;
  final String? createBy;
  final String? createTime;
  final String? currency; // CNY/HKD/USD
  final String? delFlag;
  final int? depositMethod; // 1-存入国际电汇 2-存入稳定币 3-存入BTC
  final double? expectedArrival;
  final int? packageId;
  final Map<String, dynamic>? params;
  final String? receiveAccount;
  final String? receiveBankCode;
  final String? receiveBankName;
  final String? remark;
  final double? serviceCharge;
  final double? serviceChargeRate;
  final List<String>? transferProof;
  final String? updateBy;
  final String? updateTime;

  NewDepositRequest({
    this.id,
    this.accountNo,
    this.accountType,
    required this.amount,
    this.applyTime,
    this.auditRemark,
    this.auditStatus,
    this.auditTime,
    this.bankAccount,
    this.bankCode,
    this.bankId,
    this.bankName,
    this.bankRegion,
    this.createBy,
    this.createTime,
    this.currency,
    this.delFlag,
    this.depositMethod,
    this.expectedArrival,
    this.packageId,
    this.params,
    this.receiveAccount,
    this.receiveBankCode,
    this.receiveBankName,
    this.remark,
    this.serviceCharge,
    this.serviceChargeRate,
    this.transferProof,
    this.updateBy,
    this.updateTime,
  });

  factory NewDepositRequest.fromJson(Map<String, dynamic> json) {
    return NewDepositRequest(
      id: json['id'],
      accountNo: json['accountNo'],
      accountType: json['accountType'],
      amount: (json['amount'] ?? 0.0).toDouble(),
      applyTime: json['applyTime'],
      auditRemark: json['auditRemark'],
      auditStatus: json['auditStatus'],
      auditTime: json['auditTime'],
      bankAccount: json['bankAccount'],
      bankCode: json['bankCode'],
      bankId: json['bankId'],
      bankName: json['bankName'],
      bankRegion: json['bankRegion'],
      createBy: json['createBy'],
      createTime: json['createTime'],
      currency: json['currency'],
      delFlag: json['delFlag'],
      depositMethod: json['depositMethod'],
      expectedArrival: json['expectedArrival']?.toDouble(),
      packageId: json['packageId'],
      params: json['params'],
      receiveAccount: json['receiveAccount'],
      receiveBankCode: json['receiveBankCode'],
      receiveBankName: json['receiveBankName'],
      remark: json['remark'],
      serviceCharge: json['serviceCharge']?.toDouble(),
      serviceChargeRate: json['serviceChargeRate']?.toDouble(),
      transferProof: json['transferProof'] != null
          ? List<String>.from(json['transferProof'])
          : null,
      updateBy: json['updateBy'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNo': accountNo,
      'accountType': accountType,
      'amount': amount,
      'applyTime': applyTime,
      'auditRemark': auditRemark,
      'auditStatus': auditStatus,
      'auditTime': auditTime,
      'bankAccount': bankAccount,
      'bankCode': bankCode,
      'bankId': bankId,
      'bankName': bankName,
      'bankRegion': bankRegion,
      'createBy': createBy,
      'createTime': createTime,
      'currency': currency,
      'delFlag': delFlag,
      'depositMethod': depositMethod,
      'expectedArrival': expectedArrival,
      'packageId': packageId,
      'params': params,
      'receiveAccount': receiveAccount,
      'receiveBankCode': receiveBankCode,
      'receiveBankName': receiveBankName,
      'remark': remark,
      'serviceCharge': serviceCharge,
      'serviceChargeRate': serviceChargeRate,
      'transferProof': transferProof,
      'updateBy': updateBy,
      'updateTime': updateTime,
    };
  }

  // 获取状态文本
  String get statusText {
    switch (auditStatus) {
      case 0:
        return '待审核';
      case 1:
        return '已完成';
      case 2:
        return '交易失败';
      default:
        return '未知状态';
    }
  }

  // 获取入金方式文本
  String get depositMethodText {
    switch (depositMethod) {
      case 1:
        return '存入国际电汇';
      case 2:
        return '存入稳定币';
      case 3:
        return '存入BTC';
      default:
        return '未知方式';
    }
  }
}

// 入金银行信息
class DepositBank {
  final int? id;
  final String? address;
  final String? bankAccount;
  final String? bankAccountName;
  final String? bankCode;
  final String? bankName;
  final String? bankRegion;
  final String? createBy;
  final String? createTime;
  final String? delFlag;
  final Map<String, dynamic>? params;
  final String? updateBy;
  final String? updateTime;

  DepositBank({
    this.id,
    this.address,
    this.bankAccount,
    this.bankAccountName,
    this.bankCode,
    this.bankName,
    this.bankRegion,
    this.createBy,
    this.createTime,
    this.delFlag,
    this.params,
    this.updateBy,
    this.updateTime,
  });

  factory DepositBank.fromJson(Map<String, dynamic> json) {
    return DepositBank(
      id: json['id'],
      address: json['address'],
      bankAccount: json['bankAccount'],
      bankAccountName: json['bankAccountName'],
      bankCode: json['bankCode'],
      bankName: json['bankName'],
      bankRegion: json['bankRegion'],
      createBy: json['createBy'],
      createTime: json['createTime'],
      delFlag: json['delFlag'],
      params: json['params'],
      updateBy: json['updateBy'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'bankAccount': bankAccount,
      'bankAccountName': bankAccountName,
      'bankCode': bankCode,
      'bankName': bankName,
      'bankRegion': bankRegion,
      'createBy': createBy,
      'createTime': createTime,
      'delFlag': delFlag,
      'params': params,
      'updateBy': updateBy,
      'updateTime': updateTime,
    };
  }

  // 获取银行显示名称
  String get displayName {
    if (bankRegion != null && bankName != null) {
      return '【$bankRegion】$bankName($bankCode)';
    }
    return bankName ?? '未知银行';
  }
}

// 入金申请请求
class NewDepositRequestData {
  final double amount;
  final int? bankId;
  final String? currency;
  final int? depositMethod;
  final List<String>? transferProof;
  final String? remark;

  NewDepositRequestData({
    required this.amount,
    this.bankId,
    this.currency,
    this.depositMethod,
    this.transferProof,
    this.remark,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'bankId': bankId,
      'currency': currency,
      'depositMethod': depositMethod,
      'transferProof': transferProof,
      'remark': remark,
    };
  }
}

// 入金列表响应
class NewDepositListResponse {
  final List<NewDepositRequest> data;
  final int total;
  final int page;
  final int pageSize;

  NewDepositListResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory NewDepositListResponse.fromJson(Map<String, dynamic> json) {
    return NewDepositListResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (item) =>
                    NewDepositRequest.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
    );
  }
}

// 入金银行列表响应
class DepositBankListResponse {
  final List<DepositBank> data;
  final int total;
  final int page;
  final int pageSize;

  DepositBankListResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory DepositBankListResponse.fromJson(Map<String, dynamic> json) {
    return DepositBankListResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (item) => DepositBank.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
    );
  }
}

// 服务费查询响应
class ServiceChargeResponse {
  final double serviceCharge;
  final double serviceChargeRate;
  final String currency;

  ServiceChargeResponse({
    required this.serviceCharge,
    required this.serviceChargeRate,
    required this.currency,
  });

  factory ServiceChargeResponse.fromJson(Map<String, dynamic> json) {
    return ServiceChargeResponse(
      serviceCharge: (json['serviceCharge'] ?? 0.0).toDouble(),
      serviceChargeRate: (json['serviceChargeRate'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? '',
    );
  }
}

// 出金申请数据模型
class NewWithdrawRequest {
  final int? id;
  final String? accountNo;
  final int? accountType;
  final double amount;
  final String? applyTime;
  final String? auditRemark;
  final int? auditStatus; // 0-待审核,1-审核通过,2-审核失败
  final String? auditTime;
  final String? bankAccount;
  final String? bankCode;
  final int? bankId;
  final String? bankName;
  final String? createBy;
  final String? createTime;
  final String? currency;
  final String? delFlag;
  final double? expectedArrival;
  final double? packageFee;
  final Map<String, dynamic>? params;
  final String? remark;
  final int? type;
  final String? updateBy;
  final String? updateTime;
  final String? userAccountNo;
  final int? userId;
  final String? userName;

  NewWithdrawRequest({
    this.id,
    this.accountNo,
    this.accountType,
    required this.amount,
    this.applyTime,
    this.auditRemark,
    this.auditStatus,
    this.auditTime,
    this.bankAccount,
    this.bankCode,
    this.bankId,
    this.bankName,
    this.createBy,
    this.createTime,
    this.currency,
    this.delFlag,
    this.expectedArrival,
    this.packageFee,
    this.params,
    this.remark,
    this.type,
    this.updateBy,
    this.updateTime,
    this.userAccountNo,
    this.userId,
    this.userName,
  });

  factory NewWithdrawRequest.fromJson(Map<String, dynamic> json) {
    return NewWithdrawRequest(
      id: json['id'],
      accountNo: json['accountNo'],
      accountType: json['accountType'],
      amount: (json['amount'] ?? 0.0).toDouble(),
      applyTime: json['applyTime'],
      auditRemark: json['auditRemark'],
      auditStatus: json['auditStatus'],
      auditTime: json['auditTime'],
      bankAccount: json['bankAccount'],
      bankCode: json['bankCode'],
      bankId: json['bankId'],
      bankName: json['bankName'],
      createBy: json['createBy'],
      createTime: json['createTime'],
      currency: json['currency'],
      delFlag: json['delFlag'],
      expectedArrival: json['expectedArrival']?.toDouble(),
      packageFee: json['packageFee']?.toDouble(),
      params: json['params'],
      remark: json['remark'],
      type: json['type'],
      updateBy: json['updateBy'],
      updateTime: json['updateTime'],
      userAccountNo: json['userAccountNo'],
      userId: json['userId'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNo': accountNo,
      'accountType': accountType,
      'amount': amount,
      'applyTime': applyTime,
      'auditRemark': auditRemark,
      'auditStatus': auditStatus,
      'auditTime': auditTime,
      'bankAccount': bankAccount,
      'bankCode': bankCode,
      'bankId': bankId,
      'bankName': bankName,
      'createBy': createBy,
      'createTime': createTime,
      'currency': currency,
      'delFlag': delFlag,
      'expectedArrival': expectedArrival,
      'packageFee': packageFee,
      'params': params,
      'remark': remark,
      'type': type,
      'updateBy': updateBy,
      'updateTime': updateTime,
      'userAccountNo': userAccountNo,
      'userId': userId,
      'userName': userName,
    };
  }

  // 获取状态文本
  String get statusText {
    switch (auditStatus) {
      case 0:
        return '进行中';
      case 1:
        return '已完成';
      case 2:
        return '交易失败';
      default:
        return '未知状态';
    }
  }
}

// 出金列表响应
class NewWithdrawListResponse {
  final List<NewWithdrawRequest> data;
  final int total;
  final int page;
  final int pageSize;

  NewWithdrawListResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory NewWithdrawListResponse.fromJson(Map<String, dynamic> json) {
    return NewWithdrawListResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (item) =>
                    NewWithdrawRequest.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
    );
  }
}
