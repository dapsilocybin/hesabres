import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wallet.model.dart';

class WalletsRepository {
  final _client = Supabase.instance.client;
  final table = 'wallets';

  Future<WalletModel?> getByUser(String userId) async {
    final res = await _client.from(table).select().eq('user_id', userId).maybeSingle();
    if (res == null) return null;
    return WalletModel.fromJson(res);
  }

  Future<WalletModel> update(WalletModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return WalletModel.fromJson(res);
  }
}
