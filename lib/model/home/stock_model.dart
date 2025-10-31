class Stock {
  final String name;
  final String code;
  final String annualized;
  final String shares;
  final String minEarnings;
  final int id;

  const Stock({
    required this.name,
    required this.code,
    required this.annualized,
    required this.shares,
    required this.minEarnings,
    required this.id,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'] as String,
      code: json['code'] as String,
      annualized: json['annualized'] as String,
      shares: json['shares'] as String,
      minEarnings: json['minEarnings'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'annualized': annualized,
      'shares': shares,
      'minEarnings': minEarnings,
      'id': id,
    };
  }

  Stock copyWith({
    String? name,
    String? code,
    String? annualized,
    String? shares,
    String? minEarnings,
    int? id,
  }) {
    return Stock(
      name: name ?? this.name,
      code: code ?? this.code,
      annualized: annualized ?? this.annualized,
      shares: shares ?? this.shares,
      minEarnings: minEarnings ?? this.minEarnings,
      id: id ?? this.id,
    );
  }
}

class Transaction {
  final String stock;
  final String direction;
  final String quantity;
  final String unitPrice;
  final String amount;
  final String profit;
  final String time;

  const Transaction({
    required this.stock,
    required this.direction,
    required this.quantity,
    required this.unitPrice,
    required this.amount,
    required this.profit,
    required this.time,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      stock: json['stock'] as String,
      direction: json['direction'] as String,
      quantity: json['quantity'] as String,
      unitPrice: json['unitPrice'] as String,
      amount: json['amount'] as String,
      profit: json['profit'] as String,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'direction': direction,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'amount': amount,
      'profit': profit,
      'time': time,
    };
  }
}

class PerformanceData {
  final String month;
  final double value;

  const PerformanceData({required this.month, required this.value});

  factory PerformanceData.fromJson(Map<String, dynamic> json) {
    return PerformanceData(
      month: json['month'] as String,
      value: (json['value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'month': month, 'value': value};
  }
}
