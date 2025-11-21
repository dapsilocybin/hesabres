// 2) PaymentModel
import 'package:hesabres/core/utils/date_helpers.dart';

class PaymentModel {
  final String id;
  final DateTime createdAt;
  final String orderId;
  final String? referenceId;
  final int amount; // integer in SQL
  final String? gateway;
  final int? status;
  final DateTime? paidAt;

  PaymentModel({
    required this.id,
    required this.createdAt,
    required this.orderId,
    this.referenceId,
    required this.amount,
    this.gateway,
    this.status,
    this.paidAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as String,
        createdAt: parseDate(json['created_at'])!,
        orderId: json['order_id'] as String,
        referenceId: json['reference_id'] as String?,
        amount: json['amount'] as int,
        gateway: json['gateway'] as String?,
        status: json['status'] as int?,
        paidAt: parseDate(json['paid_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': dateToIso(createdAt),
        'order_id': orderId,
        'reference_id': referenceId,
        'amount': amount,
        'gateway': gateway,
        'status': status,
        'paid_at': dateToIso(paidAt),
      };
}
