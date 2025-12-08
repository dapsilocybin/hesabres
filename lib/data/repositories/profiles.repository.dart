import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.model.dart';

class ProfilesRepository {
  final _client = Supabase.instance.client;
  final table = 'profiles';

  Future<ProfileModel?> getByAuthUserId(String authId) async {
    final res = await _client.from(table).select().eq('auth_user_id', authId).maybeSingle();
    if (res == null) return null;
    return ProfileModel.fromJson(res);
  }

  Future<ProfileModel> insert(ProfileModel data) async {
    final res = await _client.from(table).insert(data.toJson()).select().single();
    return ProfileModel.fromJson(res);
  }

  Future<ProfileModel> update(ProfileModel data) async {
    final res = await _client.from(table).update(data.toJson()).eq('id', data.id).select().single();
    return ProfileModel.fromJson(res);
  }
}
