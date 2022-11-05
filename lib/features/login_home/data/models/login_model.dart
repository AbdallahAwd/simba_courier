import 'package:simba_courier/features/login_home/domain/entities/login_entity.dart';

class LoginModel extends LoginEntities {
  const LoginModel(
      {required super.success,
      required super.message,
      required super.userProfile,
      required super.token});
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      success: json['success'],
      message: json['message'],
      userProfile: UserProfileModel.fromJson(json['user_profile']),
      token: json['token']);
}

class UserProfileModel extends UserProfile {
  const UserProfileModel(
      {required super.accountName,
      required super.name,
      required super.customerName,
      required super.phone,
      required super.profileImage});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
          accountName: json['account_name'],
          customerName: json['customer_name'],
          phone: json['phone'],
          name: json['name'],
          profileImage: json['profile_image']);
}
