import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/variant_type.model.dart';

class VariantTypesRepository {
  final _client = Supabase.instance.client;
  final table = 'variant_types';

  Future<List<VariantTypeModel>> getByStore(String storeId) async {
    final res = await _client.from(table).select().eq('store_id', storeId);
    return res.map<VariantTypeModel>((e) => VariantTypeModel.fromJson(e)).toList();
  }

  Future<VariantTypeModel> insert(VariantTypeModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return VariantTypeModel.fromJson(res);
  }

  Future<VariantTypeModel> update(VariantTypeModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return VariantTypeModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
