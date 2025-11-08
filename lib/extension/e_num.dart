import 'package:intl/intl.dart';

extension ENum on num {
  String get separator {
    if (this >= 1000) {
      return NumberFormat("#,##0.00", "en_US").format(this);
    }
    return this.toStringAsFixed(2);
  }

  String get encryption {
    final num = this.toString();
    return "*"*num.length;
  }

  String get billionFormat {
    final sign = isNegative ? '-' : '';
    final absNumber = abs();

    if (absNumber >= 1000000000000) {
      // >= 1万亿
      return "$sign${(absNumber / 1000000000000).toStringAsFixed(2)}万亿";
    }

    if (absNumber >= 100000000) {
      // >= 1亿
      return "$sign${(absNumber / 100000000).toStringAsFixed(2)}亿";
    }

    if (absNumber >= 10000) {
      // >= 1万
      return "$sign${(absNumber / 10000).toStringAsFixed(2)}万";
    }

    return "$sign${toStringAsFixed(2)}";
  }
}
