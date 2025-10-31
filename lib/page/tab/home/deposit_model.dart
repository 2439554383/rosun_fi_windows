class DepositItem {
  final int id;
  final double amount;
  final String status;
  final String? remark;
  final String createTime;
  final String? updateTime;

  DepositItem({
    required this.id,
    required this.amount,
    required this.status,
    this.remark,
    required this.createTime,
    this.updateTime,
  });

  factory DepositItem.fromJson(Map<String, dynamic> json) {
    return DepositItem(
      id: json['id'] ?? 0,
      amount: (json['amount'] ?? 0.0).toDouble(),
      status: json['status'] ?? '',
      remark: json['remark'],
      createTime: json['create_time'] ?? '',
      updateTime: json['update_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'status': status,
      'remark': remark,
      'create_time': createTime,
      'update_time': updateTime,
    };
  }
}

class DepositListResponse {
  final List<DepositItem> data;
  final int total;
  final int page;
  final int pageSize;

  DepositListResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory DepositListResponse.fromJson(Map<String, dynamic> json) {
    return DepositListResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (item) => DepositItem.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'total': total,
      'page': page,
      'pageSize': pageSize,
    };
  }
}

class DepositApplicationRequest {
  final double amount;
  final String? remark;

  DepositApplicationRequest({required this.amount, this.remark});

  factory DepositApplicationRequest.fromJson(Map<String, dynamic> json) {
    return DepositApplicationRequest(
      amount: (json['amount'] ?? 0.0).toDouble(),
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'remark': remark};
  }
}

class DepositApplicationResponse {
  final int id;
  final String message;

  DepositApplicationResponse({required this.id, required this.message});

  factory DepositApplicationResponse.fromJson(Map<String, dynamic> json) {
    return DepositApplicationResponse(
      id: json['id'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'message': message};
  }
}
