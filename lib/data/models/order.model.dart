// 1) OrderModel
import 'package:hesabres/core/utils/date_helpers.dart';

class OrderModel {
  final String id;
  final String? variantProductId;
  final int quantity;
  final String? buyerId;
  final String buyerFirstName;
  final String buyerLastName;
  final String buyerPhoneNumber;
  final String? buyerEmail;
  final String buyerAddress;
  final String buyerPostalCode;
  final String? trackingCode;
  final int totalPrice; // integer in SQL
  final int status; // integer enum
  final int paymentStatus; // integer enum
  final DateTime createdAt;
  final String productId;
  final String storeId;

  OrderModel({
    required this.id,
    this.variantProductId,
    required this.quantity,
    this.buyerId,
    required this.buyerFirstName,
    required this.buyerLastName,
    required this.buyerPhoneNumber,
    this.buyerEmail,
    required this.buyerAddress,
    required this.buyerPostalCode,
    this.trackingCode,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
    required this.productId,
    required this.storeId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'] as String,
    variantProductId: json['variant_product_id'] as String?,
    quantity: json['quantity'] as int,
    buyerId: json['buyer_id'] as String?,
    buyerFirstName: json['buyer_first_name'] as String,
    buyerLastName: json['buyer_last_name'] as String,
    buyerPhoneNumber: json['buyer_phone_number'] as String,
    buyerEmail: json['buyer_email'] as String?,
    buyerAddress: json['buyer_address'] as String,
    buyerPostalCode: json['buyer_postal_code'] as String,
    trackingCode: json['tracking_code'] as String?,
    totalPrice: json['total_price'] as int,
    status: json['status'] as int,
    paymentStatus: json['payment_status'] as int,
    createdAt: parseDate(json['created_at'])!,
    productId: json['product_id'] as String,
    storeId: json['store_id'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'variant_product_id': variantProductId,
    'quantity': quantity,
    'buyer_id': buyerId,
    'buyer_first_name': buyerFirstName,
    'buyer_last_name': buyerLastName,
    'buyer_phone_number': buyerPhoneNumber,
    'buyer_email': buyerEmail,
    'buyer_address': buyerAddress,
    'buyer_postal_code': buyerPostalCode,
    'tracking_code': trackingCode,
    'total_price': totalPrice,
    'status': status,
    'payment_status': paymentStatus,
    'created_at': dateToIso(createdAt),
    'product_id': productId,
    'store_id': storeId,
  };
}
