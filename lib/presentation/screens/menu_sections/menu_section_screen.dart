import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/menu_sections.dart';
import '../../providers/dashboard_provider.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/metric_tile.dart';
import '../../widgets/particle_background.dart';
import '../../widgets/section_container.dart';
import '../../widgets/transaction_tile.dart';

class MenuSectionScreen extends StatelessWidget {
  const MenuSectionScreen({
    super.key,
    required this.sectionId,
  });

  final String sectionId;

  @override
  Widget build(BuildContext context) {
    final section = menuSectionById(sectionId);
    if (section == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Раздел')),
        body: const Center(
          child: Text('Раздел не найден.'),
        ),
      );
    }

    final transactions = context
        .watch<DashboardProvider>()
        .transactionsByTypes(section.transactionTypes);

    return Scaffold(
      appBar: AppBar(title: Text(section.title)),
      body: ParticleBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedReveal(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: LinearGradient(
                        colors: [
                          section.accentColor.withOpacity(0.90),
                          section.accentColor.withOpacity(0.42),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: section.accentColor.withOpacity(0.24),
                          blurRadius: 38,
                          spreadRadius: -12,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(
                            section.icon,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          section.title,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          section.subtitle,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withOpacity(0.92),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 80),
                  child: SectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Актуально сейчас',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 18),
                        MetricTile(
                          title: section.highlightTitle,
                          value: section.highlightValue,
                          caption: section.highlightCaption,
                          icon: section.icon,
                          tint: section.accentColor,
                        ),
                        const SizedBox(height: 12),
                        MetricTile(
                          title: section.secondaryTitle,
                          value: section.secondaryValue,
                          caption: section.secondaryCaption,
                          icon: Icons.auto_graph_rounded,
                          tint: section.accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 140),
                  child: Text(
                    'Сервисы раздела',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                const SizedBox(height: 14),
                ...section.services.asMap().entries.map(
                      (entry) => AnimatedReveal(
                        delay: Duration(milliseconds: 180 + (entry.key * 70)),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SectionContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            section.accentColor.withOpacity(0.18),
                                            section.accentColor.withOpacity(0.08),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Icon(
                                        entry.value.icon,
                                        color: section.accentColor,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            entry.value.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(entry.value.subtitle),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(entry.value.description),
                                const SizedBox(height: 18),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: FilledButton.tonal(
                                    onPressed: () => _showServiceSheet(
                                      context,
                                      section,
                                      entry.value,
                                    ),
                                    child: Text(entry.value.actionLabel),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: 10),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    'Недавние операции по теме',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                const SizedBox(height: 14),
                ...transactions.asMap().entries.map(
                      (entry) => AnimatedReveal(
                        delay: Duration(milliseconds: 340 + (entry.key * 60)),
                        child: TransactionTile(transaction: entry.value),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceSheet(
    BuildContext context,
    MenuSectionItem section,
    SectionServiceItem service,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            section.accentColor.withOpacity(0.18),
                            section.accentColor.withOpacity(0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(service.icon, color: section.accentColor),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        service.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(service.description),
                const SizedBox(height: 18),
                Text(
                  'Что доступно в демонстрации',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '1. Просмотр синтетических данных по сценарию.\n'
                  '2. Быстрый доступ к связанным операциям и шаблонам.\n'
                  '3. Подсказки по ближайшим действиям и срокам.',
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(service.actionLabel),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.push(_resolveActionRoute(section.id));
                      },
                      child: Text(_resolveActionLabel(section.id)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _resolveActionRoute(String sectionId) {
    switch (sectionId) {
      case 'savings-future':
        return '/actions/top-up';
      case 'services-help':
        return '/actions/transfer';
      default:
        return '/actions/pay';
    }
  }

  String _resolveActionLabel(String sectionId) {
    switch (sectionId) {
      case 'savings-future':
        return 'Пополнить';
      case 'services-help':
        return 'Перевести';
      default:
        return 'Оплатить';
    }
  }
}
