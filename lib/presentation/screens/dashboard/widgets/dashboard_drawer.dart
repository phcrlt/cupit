import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/menu_sections.dart';
import '../../../../core/themes/theme_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../../widgets/premium_icon.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = context.watch<ProfileProvider>().profile;
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = theme.brightness == Brightness.dark;
    final items = themeProvider.isParentalMode
        ? [
            menuSectionItems[0],
            menuSectionItems[1],
            menuSectionItems[5],
            menuSectionItems[6],
          ]
        : menuSectionItems;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.86,
      backgroundColor:
          isDark ? AppColors.backgroundDark : theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: PremiumIcon(
                        glyph: PremiumGlyph.bank,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile?.fullName ?? 'Меню',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          themeProvider.isParentalMode
                              ? 'Упрощенный режим включен'
                              : 'Все основные разделы под рукой',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color:
                                theme.textTheme.bodySmall?.color?.withOpacity(
                              0.72,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Material(
                    color: isDark
                        ? AppColors.surfaceDarkSecondary.withOpacity(0.72)
                        : Colors.white.withOpacity(0.88),
                    borderRadius: BorderRadius.circular(16),
                    child: ListTile(
                      minVerticalPadding: 0,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 2,
                      ),
                      leading: Icon(
                        item.icon,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      title: Text(
                        item.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: theme.iconTheme.color?.withOpacity(0.55),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push(item.route);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: _DrawerButton(
                icon: Icons.palette_outlined,
                title: 'Цветовая гамма',
                subtitle:
                    '${themeProvider.isDarkMode ? 'Темная' : 'Светлая'} тема · ${themeProvider.palette.name} · ${themeProvider.accent.name}',
                onTap: () => _showAppearanceSheet(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              child: _DrawerButton(
                icon: Icons.family_restroom_outlined,
                title: 'Родительский контроль',
                subtitle: themeProvider.isParentalMode
                    ? 'Сейчас интерфейс максимально упрощен'
                    : 'Нажмите, чтобы включить упрощенный режим',
                trailing: Switch(
                  value: themeProvider.isParentalMode,
                  onChanged: (_) => themeProvider.toggleParentalMode(),
                ),
                onTap: themeProvider.toggleParentalMode,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppearanceSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final theme = Theme.of(context);

            return SafeArea(
              child: FractionallySizedBox(
                heightFactor: 0.82,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  children: [
                    Text(
                      'Оформление приложения',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Выберите тему, цветовую палитру и акцент. Все изменения применяются сразу.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 18),
                    _SheetSection(
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Темная тема'),
                        subtitle: Text(
                          themeProvider.isDarkMode
                              ? 'Сейчас включена темная тема'
                              : 'Сейчас включена светлая тема',
                        ),
                        value: themeProvider.isDarkMode,
                        onChanged: (_) => themeProvider.toggleTheme(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _SheetSection(
                      title: 'Стиль интерфейса',
                      subtitle: 'Меняет настроение карточек и поверхностей.',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: AppColors.palettes.map((palette) {
                          final isSelected =
                              palette.id == themeProvider.palette.id;

                          return ChoiceChip(
                            selected: isSelected,
                            onSelected: (_) =>
                                themeProvider.selectPalette(palette.id),
                            label: Text(palette.name),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _SheetSection(
                      title: 'Акцентный цвет',
                      subtitle: 'Используется для кнопок, выделений и анимаций.',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: AppColors.accentOptions.map((accent) {
                          final isSelected =
                              accent.id == themeProvider.accent.id;

                          return ChoiceChip(
                            selected: isSelected,
                            onSelected: (_) =>
                                themeProvider.selectAccentColor(accent.id),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _PaletteDot(color: accent.color),
                                const SizedBox(width: 8),
                                Text(accent.name),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Готово'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: isDark
          ? AppColors.surfaceDarkSecondary.withOpacity(0.72)
          : Colors.white.withOpacity(0.88),
      borderRadius: BorderRadius.circular(18),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.72),
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

class _PaletteDot extends StatelessWidget {
  const _PaletteDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SheetSection extends StatelessWidget {
  const _SheetSection({
    this.title,
    this.subtitle,
    required this.child,
  });

  final String? title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(
          theme.brightness == Brightness.dark ? 0.32 : 0.52,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.72),
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}
