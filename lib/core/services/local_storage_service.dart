import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_profile.dart';

class LocalStorageService {
  LocalStorageService({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const _themeKey = 'is_dark_theme';
  static const _paletteKey = 'accent_palette';
  static const _accentColorKey = 'accent_color';
  static const _parentalModeKey = 'is_parental_mode';
  static const _biometricEnabledKey = 'is_biometric_enabled';
  static const _isLoggedInKey = 'is_logged_in';
  static const _fullNameKey = 'full_name';
  static const _emailKey = 'email';
  static const _phoneKey = 'phone';
  static const _appNotificationsKey = 'app_notifications';
  static const _emailNotificationsKey = 'email_notifications';
  static const _smsNotificationsKey = 'sms_notifications';

  final SharedPreferences _sharedPreferences;

  bool get isDarkTheme => _sharedPreferences.getBool(_themeKey) ?? true;
  String get accentPaletteId =>
      _sharedPreferences.getString(_paletteKey) ?? 'ocean';
  String get accentColorId =>
      _sharedPreferences.getString(_accentColorKey) ?? 'azure';
  bool get isParentalMode =>
      _sharedPreferences.getBool(_parentalModeKey) ?? false;
  bool get isBiometricEnabled =>
      _sharedPreferences.getBool(_biometricEnabledKey) ?? false;

  Future<void> saveThemeMode(bool isDarkTheme) async {
    await _sharedPreferences.setBool(_themeKey, isDarkTheme);
  }

  Future<void> saveAccentPalette(String paletteId) async {
    await _sharedPreferences.setString(_paletteKey, paletteId);
  }

  Future<void> saveAccentColor(String accentColorId) async {
    await _sharedPreferences.setString(_accentColorKey, accentColorId);
  }

  Future<void> saveParentalMode(bool isEnabled) async {
    await _sharedPreferences.setBool(_parentalModeKey, isEnabled);
  }

  Future<void> saveBiometricEnabled(bool isEnabled) async {
    await _sharedPreferences.setBool(_biometricEnabledKey, isEnabled);
  }

  Future<UserProfile?> loadUserProfile() async {
    final isLoggedIn = _sharedPreferences.getBool(_isLoggedInKey) ?? false;
    if (!isLoggedIn) {
      return null;
    }

    return UserProfile(
      fullName:
          _sharedPreferences.getString(_fullNameKey) ?? 'Алексей Смирнов',
      email: _sharedPreferences.getString(_emailKey) ?? 'alexey@bank.ru',
      phone: _sharedPreferences.getString(_phoneKey) ?? '+7 900 123-45-67',
      appNotifications:
          _sharedPreferences.getBool(_appNotificationsKey) ?? true,
      emailNotifications:
          _sharedPreferences.getBool(_emailNotificationsKey) ?? false,
      smsNotifications:
          _sharedPreferences.getBool(_smsNotificationsKey) ?? true,
    );
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    await _sharedPreferences.setBool(_isLoggedInKey, true);
    await _sharedPreferences.setString(_fullNameKey, profile.fullName);
    await _sharedPreferences.setString(_emailKey, profile.email);
    await _sharedPreferences.setString(_phoneKey, profile.phone);
    await _sharedPreferences.setBool(
      _appNotificationsKey,
      profile.appNotifications,
    );
    await _sharedPreferences.setBool(
      _emailNotificationsKey,
      profile.emailNotifications,
    );
    await _sharedPreferences.setBool(
      _smsNotificationsKey,
      profile.smsNotifications,
    );
  }

  Future<void> clearUserProfile() async {
    await _sharedPreferences.setBool(_isLoggedInKey, false);
    await _sharedPreferences.remove(_fullNameKey);
    await _sharedPreferences.remove(_emailKey);
    await _sharedPreferences.remove(_phoneKey);
    await _sharedPreferences.remove(_appNotificationsKey);
    await _sharedPreferences.remove(_emailNotificationsKey);
    await _sharedPreferences.remove(_smsNotificationsKey);
  }
}
