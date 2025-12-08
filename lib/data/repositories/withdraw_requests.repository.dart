import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/withdraw_request.model.dart';

class WithdrawRequestsRepository {
  final _client = Supabase.instance.client;
  final table = 'withdraw_requests';

  Future<List<WithdrawRequestModel>> getByWallet(String walletId) async {
    final res = await _client.from(table).select().eq('wallet_id', walletId);
    return res
        .map<WithdrawRequestModel>((e) => WithdrawRequestModel.fromJson(e))
        .toList();
  }

  Future<WithdrawRequestModel> insert(WithdrawRequestModel data) async {
    final res = await _client
        .from(table)
        .insert(data.toJson())
        .select()
        .single();
    return WithdrawRequestModel.fromJson(res);
  }

  Future<WithdrawRequestModel> update(WithdrawRequestModel data) async {
    final res = await _client
        .from(table)
        .update(data.toJson())
        .eq('id', data.id)
        .select()
        .single();
    return WithdrawRequestModel.fromJson(res);
  }
}
