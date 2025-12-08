// 11) VariantValueModel
import 'package:hesabres/core/utils/date_helpers.dart';

class VariantValueModel {
  final String id;
  final String variantTypeId;
  final String value;
  final DateTime? createdAt;

  VariantValueModel({
    required this.id,
    required this.variantTypeId,
    required this.value,
    this.createdAt,
  });

  factory VariantValueModel.fromJson(Map<String, dynamic> json) =>
      VariantValueModel(
        id: json['id'] as String,
        variantTypeId: json['variant_type_id'] as String,
        value: json['value'] as String,
        createdAt: parseDate(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'variant_type_id': variantTypeId,
        'value': value,
        'created_at': dateToIso(createdAt),
      };
}
