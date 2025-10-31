// 测试请求格式
import '../new_deposit_model.dart';

void testRequestFormat() {
  // 测试数据
  final testData = NewDepositRequestData(
    amount: 1000.0,
    bankId: 1,
    currency: 'HKD',
    depositMethod: 1,
    transferProof: ['transfer_proof_1761729337884.jpg'],
    remark: '测试备注',
  );

  // 转换为JSON
  final json = testData.toJson();

  print('请求数据格式:');
  print(json);

  // 验证transferProof是数组
  assert(json['transferProof'] is List);
  assert((json['transferProof'] as List).isNotEmpty);
  assert((json['transferProof'] as List).first is String);

  print('✅ transferProof格式正确 - 数组类型');
  print('✅ 数组内容: ${json['transferProof']}');
}

// 期望的JSON格式:
/*
{
  "amount": 1000.0,
  "bankId": 1,
  "currency": "HKD",
  "depositMethod": 1,
  "transferProof": ["transfer_proof_1761729337884.jpg"],
  "remark": "测试备注"
}
*/
