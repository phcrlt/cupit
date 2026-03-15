import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._localStorageService);

  final LocalStorageService _localStorageService;

  ThemeMode _themeMode = ThemeMode.dark;
  AppAccentPalette _palette = AppColors.oceanPalette;
  AppAccentColorOption _accent = AppColors.accentOptions.first;
  bool _isParentalMode = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  AppAccentPalette get palette => _palette;
  AppAccentColorOption get accent => _accent;
  bool get isParentalMode => _isParentalMode;

  Future<void> loadTheme() async {
    _themeMode =
        _localStorageService.isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    _palette = AppColors.paletteById(_localStorageService.accentPaletteId);
    _accent = AppColors.accentById(_localStorageService.accentColorId);
    _isParentalMode = _localStorageService.isParentalMode;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _localStorageService.saveThemeMode(isDarkMode);
    notifyListeners();
  }

  Future<void> selectPalette(String paletteId) async {
    _palette = AppColors.paletteById(paletteId);
    await _localStorageService.saveAccentPalette(_palette.id);
    notifyListeners();
  }

  Future<void> selectAccentColor(String accentId) async {
    _accent = AppColors.accentById(accentId);
    await _localStorageService.saveAccentColor(_accent.id);
    notifyListeners();
  }

  Future<void> toggleParentalMode() async {
    _isParentalMode = !_isParentalMode;
    await _localStorageService.saveParentalMode(_isParentalMode);
    notifyListeners();
  }
}
