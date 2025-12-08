// 12) WalletTransactionModel
import 'package:hesabres/core/utils/date_helpers.dart';

class WalletTransactionModel {
  final String id;
  final String walletId;
  final double amount;
  final String type;
  final DateTime? createdAt;

  WalletTransactionModel({
    required this.id,
    required this.walletId,
    required this.amount,
    required this.type,
    this.createdAt,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) =>
      WalletTransactionModel(
        id: json['id'] as String,
        walletId: json['wallet_id'] as String,
        amount: (json['amount'] as num).toDouble(),
        type: json['type'] as String,
        createdAt: parseDate(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'wallet_id': walletId,
        'amount': amount,
        'type': type,
        'created_at': dateToIso(createdAt),
      };
}
