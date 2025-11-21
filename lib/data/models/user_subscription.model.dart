// 8) UserSubscriptionModel
import 'package:hesabres/core/utils/date_helpers.dart';

class UserSubscriptionModel {
  final String id;
  final DateTime createdAt;
  final String userId;
  final String planId;
  final DateTime? activeUntil;
  final bool isActive;

  UserSubscriptionModel({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.planId,
    this.activeUntil,
    required this.isActive,
  });

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      UserSubscriptionModel(
        id: json['id'] as String,
        createdAt: parseDate(json['created_at'])!,
        userId: json['user_id'] as String,
        planId: json['plan_id'] as String,
        activeUntil: parseDate(json['active_until']),
        isActive: json['is_active'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': dateToIso(createdAt),
        'user_id': userId,
        'plan_id': planId,
        'active_until': dateToIso(activeUntil),
        'is_active': isActive,
      };
}
