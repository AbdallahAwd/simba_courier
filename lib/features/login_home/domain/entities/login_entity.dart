import 'package:equatable/equatable.dart';

class LoginEntities extends Equatable {
  final bool success;
  final String message;
  final UserProfile userProfile;
  final String token;

  const LoginEntities(
      {required this.success,
      required this.message,
      required this.userProfile,
      required this.token});

  @override
  List<Object?> get props => [success, message, userProfile, token];
}

class UserProfile extends Equatable {
  final String accountName;
  final String name;
  final String customerName;
  final String phone;
  final String profileImage;

  const UserProfile(
      {required this.accountName,
      required this.name,
      required this.customerName,
      required this.phone,
      required this.profileImage});

  @override
  List<Object?> get props =>
      [accountName, name, customerName, phone, profileImage];
}
