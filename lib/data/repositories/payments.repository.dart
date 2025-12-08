import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/payment.model.dart';

class PaymentsRepository {
  final _client = Supabase.instance.client;
  final table = 'payments';

  Future<PaymentModel?> getById(String id) async {
    final res = await _client.from(table).select().eq('id', id).maybeSingle();
    if (res == null) return null;
    return PaymentModel.fromJson(res);
  }

  Future<List<PaymentModel>> getAll() async {
    final res = await _client.from(table).select();
    return res.map<PaymentModel>((e) => PaymentModel.fromJson(e)).toList();
  }

  Future<List<PaymentModel>> getPaymentsByStoreId(String storeId) async {
    final response = await _client
        .from('payments')
        .select('*, order:orders(*)') // include order info
        .eq('order.store_id', storeId); // filter by store_id on orders

    final data = response as List<dynamic>;
    return data.map((json) => PaymentModel.fromJson(json)).toList();
  }

  Future<PaymentModel> insert(PaymentModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return PaymentModel.fromJson(res);
  }

  Future<PaymentModel> update(PaymentModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return PaymentModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
