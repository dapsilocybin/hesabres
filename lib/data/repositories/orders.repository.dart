import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order.model.dart';

class OrdersRepository {
  final _client = Supabase.instance.client;
  final String table = 'orders';

  Future<OrderModel?> getById(String id) async {
    final res = await _client.from(table).select().eq('id', id).maybeSingle();
    if (res == null) return null;
    return OrderModel.fromJson(res);
  }

  Future<List<OrderModel>> getAll() async {
    final res = await _client.from(table).select();
    return res.map<OrderModel>((e) => OrderModel.fromJson(e)).toList();
  }

  Future<List<OrderModel>> getOrdersByStoreId(String storeId) async {
    final response = await _client
        .from('orders')
        .select()
        .eq('store_id', storeId); // direct store_id link
    final data = response as List<dynamic>;
    return data.map((json) => OrderModel.fromJson(json)).toList();
  }

  Future<List<OrderModel>> getOrdersByBuyerId(String buyerId) async {
    final response = await _client
        .from('orders')
        .select()
        .eq('buyer_id', buyerId); // direct store_id link
    final data = response as List<dynamic>;
    return data.map((json) => OrderModel.fromJson(json)).toList();
  }

  Future<OrderModel> insert(OrderModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return OrderModel.fromJson(res);
  }

  Future<OrderModel> update(OrderModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return OrderModel.fromJson(res);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
