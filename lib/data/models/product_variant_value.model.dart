// 4) ProductVariantValueModel (join table)
class ProductVariantValueModel {
  final String variantProductId;
  final String variantValueId;

  ProductVariantValueModel({
    required this.variantProductId,
    required this.variantValueId,
  });

  factory ProductVariantValueModel.fromJson(Map<String, dynamic> json) =>
      ProductVariantValueModel(
        variantProductId: json['variant_product_id'] as String,
        variantValueId: json['variant_value_id'] as String,
      );

  Map<String, dynamic> toJson() => {
        'variant_product_id': variantProductId,
        'variant_value_id': variantValueId,
      };
}
