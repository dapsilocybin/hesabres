import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/plan.model.dart';

class PlansRepository {
  final _client = Supabase.instance.client;
  final table = 'plans';

  Future<PlanModel?> getById(String id) async {
    final res = await _client.from(table).select().eq('id', id).maybeSingle();
    if (res == null) return null;
    return PlanModel.fromJson(res);
  }

  Future<List<PlanModel>> getAll() async {
    final res = await _client.from(table).select();
    return res.map<PlanModel>((e) => PlanModel.fromJson(e)).toList();
  }

  Future<PlanModel> insert(PlanModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return PlanModel.fromJson(res);
  }

  Future<PlanModel> update(PlanModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return PlanModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
