// 7) StoreModel
import 'package:hesabres/core/utils/date_helpers.dart';

class StoreModel {
  final String id;
  final DateTime createdAt;
  final String ownerId;
  final String title;
  final String businessLink;
  final String? description;

  StoreModel({
    required this.id,
    required this.createdAt,
    required this.ownerId,
    required this.title,
    required this.businessLink,
    this.description,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json['id'] as String,
        createdAt: parseDate(json['created_at'])!,
        ownerId: json['owner_id'] as String,
        title: json['title'] as String,
        businessLink: json['business_link'] as String,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': dateToIso(createdAt),
        'owner_id': ownerId,
        'title': title,
        'business_link': businessLink,
        'description': description,
      };
}
