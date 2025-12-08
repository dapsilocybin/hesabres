import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/variant_product.model.dart';

class VariantProductsRepository {
  final _client = Supabase.instance.client;
  final table = 'variant_products';

  Future<VariantProductModel?> getById(String id) async {
    final res = await _client.from(table).select().eq('id', id).maybeSingle();
    if (res == null) return null;
    return VariantProductModel.fromJson(res);
  }

  Future<List<VariantProductModel>> getByProduct(String productId) async {
    final res = await _client.from(table).select().eq('product_id', productId);
    return res.map<VariantProductModel>((e) => VariantProductModel.fromJson(e)).toList();
  }

  Future<VariantProductModel> insert(VariantProductModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return VariantProductModel.fromJson(res);
  }

  Future<VariantProductModel> update(VariantProductModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return VariantProductModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
