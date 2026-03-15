import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/themes/theme_provider.dart';
import '../../../data/models/user_profile.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/particle_background.dart';
import '../../widgets/section_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _phoneLoginController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _appNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;
  String? _loadedProfileKey;

  @override
  void dispose() {
    _phoneLoginController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ParticleBackground(
        child: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final profile = provider.profile;
            if (profile == null) {
              return _buildLoginForm(context, provider);
            }

            _hydrateProfile(profile);
            return _buildProfileForm(context, provider);
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, ProfileProvider provider) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: AnimatedReveal(
            child: SectionContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Вход в профиль',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Введите номер телефона, чтобы открыть личный кабинет. При желании можно включить биометрический вход.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 22),
                  TextField(
                    controller: _phoneLoginController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Номер телефона',
                      hintText: '+7 900 123-45-67',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => _handleLogin(context, provider),
                      child: const Text('Войти'),
                    ),
                  ),
                  const SizedBox(height: 22),
                  _buildAppearanceSettings(context, provider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context, ProfileProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Column(
            children: [
              AnimatedReveal(
                child: SectionContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Личные данные',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'ФИО',
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Электронная почта',
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Телефон',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              AnimatedReveal(
                delay: const Duration(milliseconds: 80),
                child: SectionContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Настройки уведомлений',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        value: _appNotifications,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Уведомления в приложении'),
                        onChanged: (value) {
                          setState(() {
                            _appNotifications = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        value: _emailNotifications,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Письма на электронную почту'),
                        onChanged: (value) {
                          setState(() {
                            _emailNotifications = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        value: _smsNotifications,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('СМС-уведомления'),
                        onChanged: (value) {
                          setState(() {
                            _smsNotifications = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              AnimatedReveal(
                delay: const Duration(milliseconds: 160),
                child: SectionContainer(
                  child: _buildAppearanceSettings(context, provider),
                ),
              ),
              const SizedBox(height: 18),
              AnimatedReveal(
                delay: const Duration(milliseconds: 220),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          await provider.saveProfile(
                            UserProfile(
                              fullName: _fullNameController.text.trim(),
                              email: _emailController.text.trim(),
                              phone: _phoneController.text.trim(),
                              appNotifications: _appNotifications,
                              emailNotifications: _emailNotifications,
                              smsNotifications: _smsNotifications,
                            ),
                          );
                          _showSnackBar(context, 'Профиль сохранен');
                        },
                        child: const Text('Сохранить'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          await provider.logout();
                          _loadedProfileKey = null;
                          _phoneLoginController.clear();
                          _showSnackBar(context, 'Вы вышли из профиля');
                        },
                        child: const Text('Выйти'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppearanceSettings(
    BuildContext context,
    ProfileProvider provider,
  ) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = Theme.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Внешний вид и безопасность',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Темная тема'),
              subtitle: Text(
                themeProvider.isDarkMode
                    ? 'Сейчас активна темная тема'
                    : 'Сейчас активна светлая тема',
              ),
              value: themeProvider.isDarkMode,
              onChanged: (_) => themeProvider.toggleTheme(),
            ),
            const SizedBox(height: 8),
            Text(
              'Стиль интерфейса',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppColors.palettes.map((palette) {
                final isSelected = palette.id == themeProvider.palette.id;

                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) => themeProvider.selectPalette(palette.id),
                  label: Text(palette.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Акцентный цвет',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppColors.accentOptions.map((accent) {
                final isSelected = accent.id == themeProvider.accent.id;

                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) =>
                      themeProvider.selectAccentColor(accent.id),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: accent.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(accent.name),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Родительский контроль',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              themeProvider.isParentalMode
                                  ? 'Интерфейс уже упрощен до самых важных действий.'
                                  : 'Включите, чтобы сделать приложение максимально простым.',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Switch(
                        value: themeProvider.isParentalMode,
                        onChanged: (_) => themeProvider.toggleParentalMode(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Биометрический вход',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              provider.isBiometricEnabled
                                  ? 'Face ID / Touch ID будет имитироваться при входе.'
                                  : 'Можно включить быстрый вход по биометрии.',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Switch(
                        value: provider.isBiometricEnabled,
                        onChanged: provider.setBiometricEnabled,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogin(
    BuildContext context,
    ProfileProvider provider,
  ) async {
    if (_phoneLoginController.text.trim().isEmpty) {
      _showSnackBar(context, 'Введите номер телефона');
      return;
    }

    if (provider.isBiometricEnabled) {
      final approved = await _showBiometricDialog(context);
      if (!approved) {
        _showSnackBar(context, 'Вход отменен');
        return;
      }
    }

    await provider.login(_phoneLoginController.text.trim());
    _showSnackBar(context, 'Вход выполнен');
  }

  Future<bool> _showBiometricDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Биометрический вход'),
          content: const Text(
            'Подтвердите вход по Face ID / Touch ID. Это синтетическая имитация биометрии внутри демонстрационного приложения.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Подтвердить'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  void _hydrateProfile(UserProfile profile) {
    final profileKey =
        '${profile.fullName}|${profile.email}|${profile.phone}|${profile.appNotifications}|${profile.emailNotifications}|${profile.smsNotifications}';
    if (_loadedProfileKey == profileKey) {
      return;
    }

    _loadedProfileKey = profileKey;
    _fullNameController.text = profile.fullName;
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
    _phoneLoginController.text = profile.phone;
    _appNotifications = profile.appNotifications;
    _emailNotifications = profile.emailNotifications;
    _smsNotifications = profile.smsNotifications;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}
