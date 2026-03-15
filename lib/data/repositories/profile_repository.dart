import '../../core/services/local_storage_service.dart';
import '../models/user_profile.dart';

class ProfileRepository {
  ProfileRepository(this._localStorageService);

  final LocalStorageService _localStorageService;

  Future<UserProfile?> getProfile() {
    return _localStorageService.loadUserProfile();
  }

  Future<void> saveProfile(UserProfile profile) {
    return _localStorageService.saveUserProfile(profile);
  }

  Future<void> clearProfile() {
    return _localStorageService.clearUserProfile();
  }

  bool get isBiometricEnabled => _localStorageService.isBiometricEnabled;

  Future<void> saveBiometricEnabled(bool isEnabled) {
    return _localStorageService.saveBiometricEnabled(isEnabled);
  }
}
