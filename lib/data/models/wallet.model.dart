// 13) WalletModel
import 'package:hesabres/core/utils/date_helpers.dart';

class WalletModel {
  final String id;
  final String userId;
  final double balance;
  final DateTime? createdAt;
  final int paymentPeriodType;

  WalletModel({
    required this.id,
    required this.userId,
    required this.balance,
    this.createdAt,
    required this.paymentPeriodType,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        balance: (json['balance'] as num).toDouble(),
        createdAt: parseDate(json['created_at']),
        paymentPeriodType: json['payment_period_type'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'balance': balance,
        'created_at': dateToIso(createdAt),
        'payment_period_type': paymentPeriodType,
      };
}
