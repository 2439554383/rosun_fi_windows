extension EString on String {
  /// 判断是否为邮箱
  bool get isEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  String add([num value = 1]) {
    num number = num.parse(this);
    number += value;
    return number.toString(); // ✅ 返回新字符串
  }

  String reduce([num value = 1]) {
    num number = num.parse(this);
    number -= value;
    return number.toString(); // ✅ 返回新字符串
  }

  num get toNum => num.parse(this);

  String get encryption {
    return "*" * this.length;
  }

  /// 判断是否为手机号（以1开头的11位数字，中国大陆规则）
  bool get isPhone {
    final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
    return phoneRegex.hasMatch(this);
  }

  /// 判断是否为6位数字密码
  bool get isSixDigitPassword {
    final sixDigitRegex = RegExp(r'^\d{6}$');
    return sixDigitRegex.hasMatch(this);
  }

  /// 判断是否为至少6位，且含有大小写字母和数字的密码
  bool get isStrongPassword {
    final strongPwdRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$',
    );
    return strongPwdRegex.hasMatch(this);
  }

  //获取
}
