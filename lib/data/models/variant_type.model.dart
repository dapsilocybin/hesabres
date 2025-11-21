// 10) VariantTypeModel
import 'package:hesabres/core/utils/date_helpers.dart';

class VariantTypeModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final String storeId;

  VariantTypeModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.storeId,
  });

  factory VariantTypeModel.fromJson(Map<String, dynamic> json) =>
      VariantTypeModel(
        id: json['id'] as String,
        name: json['name'] as String,
        createdAt: parseDate(json['created_at'])!,
        storeId: json['store_id'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': dateToIso(createdAt),
        'store_id': storeId,
      };
}
