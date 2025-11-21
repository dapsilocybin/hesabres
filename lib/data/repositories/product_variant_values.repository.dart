import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_variant_value.model.dart';

class ProductVariantValuesRepository {
  final _client = Supabase.instance.client;
  final table = 'product_variant_values';

  Future<List<ProductVariantValueModel>> getByVariantProduct(String id) async {
    final res = await _client.from(table).select().eq('variant_product_id', id);
    return res.map<ProductVariantValueModel>((e) => ProductVariantValueModel.fromJson(e)).toList();
  }

  Future<void> insert(ProductVariantValueModel data) async {
    await _client.from(table).insert(data.toJson());
  }

  Future<void> delete(String variantProductId, String variantValueId) async {
    await _client
        .from(table)
        .delete()
        .eq('variant_product_id', variantProductId)
        .eq('variant_value_id', variantValueId);
  }
}
