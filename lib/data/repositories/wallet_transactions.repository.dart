import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wallet_transaction.model.dart';

class WalletTransactionsRepository {
  final _client = Supabase.instance.client;
  final table = 'wallet_transactions';

  Future<List<WalletTransactionModel>> getByWallet(String walletId) async {
    final res = await _client.from(table).select().eq('wallet_id', walletId);
    return res.map<WalletTransactionModel>((e) => WalletTransactionModel.fromJson(e)).toList();
  }

  Future<WalletTransactionModel> insert(WalletTransactionModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return WalletTransactionModel.fromJson(res);
  }
}
