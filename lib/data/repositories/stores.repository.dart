import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/store.model.dart';

class StoresRepository {
  final _client = Supabase.instance.client;
  final table = 'stores';

  Future<StoreModel?> getById(String id) async {
    final res = await _client.from(table).select().eq('id', id).maybeSingle();
    if (res == null) return null;
    return StoreModel.fromJson(res);
  }

  Future<List<StoreModel>> getByOwner(String ownerId) async {
    final res = await _client.from(table).select().eq('owner_id', ownerId);
    return res.map<StoreModel>((e) => StoreModel.fromJson(e)).toList();
  }

  Future<StoreModel> insert(StoreModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return StoreModel.fromJson(res);
  }

  Future<StoreModel> update(StoreModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return StoreModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
