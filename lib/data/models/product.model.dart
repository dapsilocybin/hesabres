// 5) ProductModel
import 'package:hesabres/core/utils/date_helpers.dart';

class ProductModel {
  final String id;
  final DateTime createdAt;
  final String storeId;
  final String name;
  final String? description;
  final double basePrice;
  final String? code;
  final String? qrImageUrl;
  final bool isActive;
  final int totalStock;

  ProductModel({
    required this.id,
    required this.createdAt,
    required this.storeId,
    required this.name,
    this.description,
    required this.basePrice,
    this.code,
    this.qrImageUrl,
    required this.isActive,
    required this.totalStock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as String,
        createdAt: parseDate(json['created_at'])!,
        storeId: json['store_id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        basePrice: (json['base_price'] as num).toDouble(),
        code: json['code'] as String?,
        qrImageUrl: json['qr_image_url'] as String?,
        isActive: json['is_active'] as bool,
        totalStock: json['total_stock'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': dateToIso(createdAt),
        'store_id': storeId,
        'name': name,
        'description': description,
        'base_price': basePrice,
        'code': code,
        'qr_image_url': qrImageUrl,
        'is_active': isActive,
        'total_stock': totalStock,
      };
}
