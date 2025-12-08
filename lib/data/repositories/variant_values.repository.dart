import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/variant_value.model.dart';

class VariantValuesRepository {
  final _client = Supabase.instance.client;
  final table = 'variant_values';

  Future<List<VariantValueModel>> getByType(String typeId) async {
    final res = await _client.from(table).select().eq('variant_type_id', typeId);
    return res.map<VariantValueModel>((e) => VariantValueModel.fromJson(e)).toList();
  }

  Future<VariantValueModel> insert(VariantValueModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return VariantValueModel.fromJson(res);
  }

  Future<VariantValueModel> update(VariantValueModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return VariantValueModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
