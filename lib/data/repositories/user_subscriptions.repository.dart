import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_subscription.model.dart';

class UserSubscriptionsRepository {
  final _client = Supabase.instance.client;
  final table = 'user_subscriptions';

  Future<UserSubscriptionModel?> getActiveSubscription(String userId) async {
    final res = await _client
        .from(table)
        .select()
        .eq('user_id', userId)
        .eq('is_active', true)
        .maybeSingle();

    if (res == null) return null;
    return UserSubscriptionModel.fromJson(res);
  }

  Future<UserSubscriptionModel> insert(UserSubscriptionModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return UserSubscriptionModel.fromJson(res);
  }

  Future<UserSubscriptionModel> update(UserSubscriptionModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return UserSubscriptionModel.fromJson(res);
  }
}
