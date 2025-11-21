import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.model.dart';

class ProductsRepository {
  final _client = Supabase.instance.client;
  final table = 'products';

  Future<ProductModel?> getById(String id) async {
    final res = await _client.from(table).select().eq('id', id).maybeSingle();
    if (res == null) return null;
    return ProductModel.fromJson(res);
  }

  Future<List<ProductModel>> getAll() async {
    final res = await _client.from(table).select();
    return res.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getByStore(String storeId) async {
    final res = await _client.from(table).select().eq('store_id', storeId);
    return res.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
  }

  Future<ProductModel> insert(ProductModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return ProductModel.fromJson(res);
  }

  Future<ProductModel> update(ProductModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return ProductModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
