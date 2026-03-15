import 'package:flutter/material.dart';

class AppAccentPalette {
  const AppAccentPalette({
    required this.id,
    required this.name,
    required this.secondary,
    required this.cardStart,
    required this.cardEnd,
  });

  final String id;
  final String name;
  final Color secondary;
  final Color cardStart;
  final Color cardEnd;
}

class AppAccentColorOption {
  const AppAccentColorOption({
    required this.id,
    required this.name,
    required this.color,
  });

  final String id;
  final String name;
  final Color color;
}

class AppColors {
  static const backgroundDark = Color(0xFF07111B);
  static const surfaceDark = Color(0xFF0F1C29);
  static const surfaceDarkSecondary = Color(0xFF162637);
  static const accentGreen = Color(0xFF3ED3A1);
  static const accentBlue = Color(0xFF4B7BFF);
  static const textMuted = Color(0xFF8CA0B3);

  static const oceanPalette = AppAccentPalette(
    id: 'ocean',
    name: 'Океан',
    secondary: Color(0xFF3ED3A1),
    cardStart: Color(0xFF18304A),
    cardEnd: Color(0xFF0B1B2D),
  );

  static const mintPalette = AppAccentPalette(
    id: 'mint',
    name: 'Мята',
    secondary: Color(0xFF76D977),
    cardStart: Color(0xFF113238),
    cardEnd: Color(0xFF0B2126),
  );

  static const sunsetPalette = AppAccentPalette(
    id: 'sunset',
    name: 'Закат',
    secondary: Color(0xFFFFC15C),
    cardStart: Color(0xFF3E2230),
    cardEnd: Color(0xFF221521),
  );

  static const berryPalette = AppAccentPalette(
    id: 'berry',
    name: 'Рубин',
    secondary: Color(0xFF8E7BFF),
    cardStart: Color(0xFF351B31),
    cardEnd: Color(0xFF1C1121),
  );

  static const graphitePalette = AppAccentPalette(
    id: 'graphite',
    name: 'Графит',
    secondary: Color(0xFF8FB6FF),
    cardStart: Color(0xFF1D2430),
    cardEnd: Color(0xFF0F141B),
  );

  static const sandPalette = AppAccentPalette(
    id: 'sand',
    name: 'Песок',
    secondary: Color(0xFFDFC49B),
    cardStart: Color(0xFF3A2C23),
    cardEnd: Color(0xFF1D1713),
  );

  static const palettes = [
    oceanPalette,
    mintPalette,
    sunsetPalette,
    berryPalette,
    graphitePalette,
    sandPalette,
  ];

  static const accentOptions = [
    AppAccentColorOption(
      id: 'azure',
      name: 'Лазурный',
      color: Color(0xFF4B7BFF),
    ),
    AppAccentColorOption(
      id: 'emerald',
      name: 'Изумрудный',
      color: Color(0xFF27C39F),
    ),
    AppAccentColorOption(
      id: 'coral',
      name: 'Коралловый',
      color: Color(0xFFFF805B),
    ),
    AppAccentColorOption(
      id: 'violet',
      name: 'Аметист',
      color: Color(0xFF8A6CFF),
    ),
    AppAccentColorOption(
      id: 'amber',
      name: 'Янтарный',
      color: Color(0xFFE2A93B),
    ),
    AppAccentColorOption(
      id: 'ice',
      name: 'Ледяной',
      color: Color(0xFF00A7C4),
    ),
  ];

  static AppAccentPalette paletteById(String? id) {
    for (final palette in palettes) {
      if (palette.id == id) {
        return palette;
      }
    }

    return oceanPalette;
  }

  static AppAccentColorOption accentById(String? id) {
    for (final accent in accentOptions) {
      if (accent.id == id) {
        return accent;
      }
    }

    return accentOptions.first;
  }
}
