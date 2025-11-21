// 6) ProfileModel
import 'package:hesabres/core/utils/date_helpers.dart';

class ProfileModel {
  final String id;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final String authUserId;
  final String phoneNumber;
  final String? businessLink;
  final String bankAccountNumber;
  final String address;
  final String postalCode;

  ProfileModel({
    required this.id,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.authUserId,
    required this.phoneNumber,
    this.businessLink,
    required this.bankAccountNumber,
    required this.address,
    required this.postalCode,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] as String,
        createdAt: parseDate(json['created_at'])!,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        authUserId: json['auth_user_id'] as String,
        phoneNumber: json['phone_number'] as String,
        businessLink: json['business_link'] as String?,
        bankAccountNumber: json['bank_account_number'] as String,
        address: json['address'] as String,
        postalCode: json['postal_code'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': dateToIso(createdAt),
        'first_name': firstName,
        'last_name': lastName,
        'auth_user_id': authUserId,
        'phone_number': phoneNumber,
        'business_link': businessLink,
        'bank_account_number': bankAccountNumber,
        'address': address,
        'postal_code': postalCode,
      };
}
