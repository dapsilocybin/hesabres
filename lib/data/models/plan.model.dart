// 3) PlanModel
import 'package:hesabres/core/utils/date_helpers.dart';

class PlanModel {
  final String id;
  final DateTime createdAt;
  final String title;
  final String? description;
  final double monthlyPrice;
  final int? storesCountLimit;
  final int? registeredProductsCountLimit;
  final int? dailySubmittingOrdersCountLimit;

  PlanModel({
    required this.id,
    required this.createdAt,
    required this.title,
    this.description,
    required this.monthlyPrice,
    this.storesCountLimit,
    this.registeredProductsCountLimit,
    this.dailySubmittingOrdersCountLimit,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        id: json['id'] as String,
        createdAt: parseDate(json['created_at'])!,
        title: json['title'] as String,
        description: json['description'] as String?,
        monthlyPrice: (json['monthly_price'] as num).toDouble(),
        storesCountLimit: json['stores_count_limit'] as int?,
        registeredProductsCountLimit:
            json['registered_products_count_limit'] as int?,
        dailySubmittingOrdersCountLimit:
            json['daily_submitting_orders_count_limit'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': dateToIso(createdAt),
        'title': title,
        'description': description,
        'monthly_price': monthlyPrice,
        'stores_count_limit': storesCountLimit,
        'registered_products_count_limit': registeredProductsCountLimit,
        'daily_submitting_orders_count_limit': dailySubmittingOrdersCountLimit,
      };
}
