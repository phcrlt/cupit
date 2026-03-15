import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.appNotifications,
    required this.emailNotifications,
    required this.smsNotifications,
  });

  final String fullName;
  final String email;
  final String phone;
  final bool appNotifications;
  final bool emailNotifications;
  final bool smsNotifications;

  UserProfile copyWith({
    String? fullName,
    String? email,
    String? phone,
    bool? appNotifications,
    bool? emailNotifications,
    bool? smsNotifications,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        email,
        phone,
        appNotifications,
        emailNotifications,
        smsNotifications,
      ];
}
