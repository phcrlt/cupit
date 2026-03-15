import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/themes/theme_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/financial_tips_card.dart';
import '../../widgets/metric_tile.dart';
import '../../widgets/particle_background.dart';
import '../../widgets/premium_icon.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/section_container.dart';
import '../../widgets/transaction_tile.dart';
import 'widgets/account_card.dart';
import 'widgets/dashboard_drawer.dart';
import 'widgets/expense_pie_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final iconColor = Theme.of(context).iconTheme.color;

    return Scaffold(
      drawer: const DashboardDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: PremiumIcon(
                glyph: PremiumGlyph.menu,
                color: iconColor,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: Text(themeProvider.isParentalMode ? 'Главное' : 'Главная'),
        actions: [
          IconButton(
            onPressed: () => context.push('/profile'),
            icon: PremiumIcon(
              glyph: PremiumGlyph.profile,
              color: iconColor,
            ),
          ),
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              return IconButton(
                onPressed: () => context.push('/notifications'),
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    PremiumIcon(
                      glyph: PremiumGlyph.bell,
                      color: iconColor,
                    ),
                    if (notificationProvider.unreadCount > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            notificationProvider.unreadCount > 9
                                ? '9+'
                                : notificationProvider.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.cards.isEmpty) {
            return const Center(
              child: Text('Нет доступных карт'),
            );
          }

          return ParticleBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.screenPadding),
                child: themeProvider.isParentalMode
                    ? _SimplifiedDashboard(provider: provider)
                    : _FullDashboard(provider: provider),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FullDashboard extends StatelessWidget {
  const _FullDashboard({required this.provider});

  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedReveal(
          child: SizedBox(
            height: 246,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(4, 8, 20, 22),
              itemCount: provider.cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final card = provider.cards[index];
                return SizedBox(
                  width: 320,
                  child: Hero(
                    tag: 'card-${card.id}',
                    child: AccountCard(card: card),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 80),
          child: SectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Финансовый обзор',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 18),
                MetricTile(
                  title: 'Всего на счетах',
                  value: AppFormatters.formatBalance(provider.totalBalance),
                  caption: 'Сумма по всем активным продуктам',
                  icon: Icons.account_balance_wallet_rounded,
                ),
                const SizedBox(height: 12),
                MetricTile(
                  title: 'Поступления за месяц',
                  value: AppFormatters.formatBalance(provider.monthlyIncome),
                  caption: 'Зарплата, возвраты и пополнения',
                  icon: Icons.trending_up_rounded,
                  tint: Colors.green,
                ),
                const SizedBox(height: 12),
                MetricTile(
                  title: 'Расходы за месяц',
                  value: AppFormatters.formatBalance(provider.monthlyExpenses),
                  caption: 'Платежи, переводы и покупки',
                  icon: Icons.trending_down_rounded,
                  tint: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 140),
          child: const _QuickActionsRow(isSimplified: false),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 200),
          child: FinancialTipsCard(tips: provider.financialTips),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 260),
          child: SectionContainer(
            child: ExpensePieChart(
              expenseCategories: provider.expenseCategories,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 320),
          child: Text(
            'Последние операции',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const SizedBox(height: 14),
        ...provider.transactions.take(5).toList().asMap().entries.map(
              (entry) => AnimatedReveal(
                delay: Duration(milliseconds: 360 + (entry.key * 60)),
                child: TransactionTile(transaction: entry.value),
              ),
            ),
      ],
    );
  }
}

class _SimplifiedDashboard extends StatelessWidget {
  const _SimplifiedDashboard({required this.provider});

  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    final card = provider.cards.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedReveal(
          child: SectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Упрощенный режим',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'На экране оставлены только самые понятные и важные действия.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 80),
          child: Hero(
            tag: 'card-${card.id}',
            child: AccountCard(card: card),
          ),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 140),
          child: MetricTile(
            title: 'Доступно сейчас',
            value: AppFormatters.formatBalance(card.balance),
            caption: 'Основная карта · ${card.maskedNumber}',
            icon: Icons.account_balance_wallet_rounded,
          ),
        ),
        const SizedBox(height: 12),
        AnimatedReveal(
          delay: const Duration(milliseconds: 200),
          child: MetricTile(
            title: 'Последнее поступление',
            value: AppFormatters.formatBalance(provider.monthlyIncome),
            caption: 'Поступления за текущий месяц',
            icon: Icons.trending_up_rounded,
            tint: Colors.green,
          ),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 260),
          child: const _QuickActionsRow(isSimplified: true),
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AnimatedReveal(
          delay: const Duration(milliseconds: 320),
          child: Text(
            'Недавние операции',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const SizedBox(height: 14),
        ...provider.transactions.take(3).toList().asMap().entries.map(
              (entry) => AnimatedReveal(
                delay: Duration(milliseconds: 360 + (entry.key * 60)),
                child: TransactionTile(transaction: entry.value),
              ),
            ),
      ],
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow({required this.isSimplified});

  final bool isSimplified;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isSimplified ? 'Что можно сделать' : 'Быстрые действия',
          style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              QuickActionButton(
                icon: PremiumIcon(
                  glyph: PremiumGlyph.topUp,
                  color: theme.colorScheme.primary,
                  size: 26,
                ),
                label: 'Пополнить',
                onTap: () => context.push('/actions/top-up'),
              ),
              const SizedBox(width: 12),
              QuickActionButton(
                icon: PremiumIcon(
                  glyph: PremiumGlyph.pay,
                  color: theme.colorScheme.primary,
                  size: 26,
                ),
                label: 'Оплатить',
                onTap: () => context.push('/actions/pay'),
              ),
              const SizedBox(width: 12),
              QuickActionButton(
                icon: PremiumIcon(
                  glyph: PremiumGlyph.transfer,
                  color: theme.colorScheme.primary,
                  size: 26,
                ),
                label: 'Перевести',
                onTap: () => context.push('/actions/transfer'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
