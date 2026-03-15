import 'package:flutter/foundation.dart';

import '../../data/models/user_profile.dart';
import '../../data/repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  bool _isLoading = false;
  UserProfile? _profile;
  bool _isBiometricEnabled = false;

  bool get isLoading => _isLoading;
  UserProfile? get profile => _profile;
  bool get isLoggedIn => _profile != null;
  bool get isBiometricEnabled => _isBiometricEnabled;

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    _profile = await _profileRepository.getProfile();
    _isBiometricEnabled = _profileRepository.isBiometricEnabled;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> login(String phone) async {
    _profile = UserProfile(
      fullName: 'Новый клиент',
      email: 'example@bank.ru',
      phone: phone,
      appNotifications: true,
      emailNotifications: false,
      smsNotifications: true,
    );
    await _profileRepository.saveProfile(_profile!);
    notifyListeners();
  }

  Future<void> saveProfile(UserProfile profile) async {
    _profile = profile;
    await _profileRepository.saveProfile(profile);
    notifyListeners();
  }

  Future<void> logout() async {
    await _profileRepository.clearProfile();
    _profile = null;
    notifyListeners();
  }

  Future<void> setBiometricEnabled(bool isEnabled) async {
    _isBiometricEnabled = isEnabled;
    await _profileRepository.saveBiometricEnabled(isEnabled);
    notifyListeners();
  }
}
