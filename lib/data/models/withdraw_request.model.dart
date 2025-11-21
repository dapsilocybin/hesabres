// 14) WithdrawRequestModel
import 'package:hesabres/core/utils/date_helpers.dart';

class WithdrawRequestModel {
  final String id;
  final String? walletId;
  final double amount;
  final String status;
  final DateTime? createdAt;

  WithdrawRequestModel({
    required this.id,
    this.walletId,
    required this.amount,
    required this.status,
    this.createdAt,
  });

  factory WithdrawRequestModel.fromJson(Map<String, dynamic> json) =>
      WithdrawRequestModel(
        id: json['id'] as String,
        walletId: json['wallet_id'] as String?,
        amount: (json['amount'] as num).toDouble(),
        status: json['status'] as String,
        createdAt: parseDate(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'wallet_id': walletId,
        'amount': amount,
        'status': status,
        'created_at': dateToIso(createdAt),
      };
}
