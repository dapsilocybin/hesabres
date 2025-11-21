// 9) VariantProductModel
import 'package:hesabres/core/utils/date_helpers.dart';

class VariantProductModel {
  final String id;
  final String productId;
  final double? price;
  final int stock;
  final DateTime? createdAt;
  final String? description;

  VariantProductModel({
    required this.id,
    required this.productId,
    this.price,
    required this.stock,
    this.createdAt,
    this.description,
  });

  factory VariantProductModel.fromJson(Map<String, dynamic> json) =>
      VariantProductModel(
        id: json['id'] as String,
        productId: json['product_id'] as String,
        price: json['price'] != null ? (json['price'] as num).toDouble() : null,
        stock: json['stock'] as int,
        createdAt: parseDate(json['created_at']),
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'price': price,
        'stock': stock,
        'created_at': dateToIso(createdAt),
        'description': description,
      };
}
