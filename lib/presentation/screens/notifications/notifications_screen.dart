import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/formatters.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/metric_tile.dart';
import '../../widgets/particle_background.dart';
import '../../widgets/section_container.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();
    final notifications = provider.notifications;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Уведомления'),
        actions: [
          TextButton(
            onPressed: notifications.isEmpty ? null : provider.markAllAsRead,
            child: const Text('Прочитать все'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ParticleBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AnimatedReveal(
              child: SectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Центр событий',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 18),
                    MetricTile(
                      title: 'Непрочитанные',
                      value: provider.unreadCount.toString(),
                      caption: 'Требуют внимания прямо сейчас',
                      icon: Icons.mark_email_unread_outlined,
                    ),
                    const SizedBox(height: 12),
                    MetricTile(
                      title: 'Всего уведомлений',
                      value: notifications.length.toString(),
                      caption: 'Финансовые события, напоминания и статусы',
                      icon: Icons.notifications_active_outlined,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...notifications.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return AnimatedReveal(
                delay: Duration(milliseconds: 80 + (index * 60)),
                child: GestureDetector(
                  onTap: () =>
                      context.read<NotificationProvider>().markAsRead(item.id),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(
                        theme.brightness == Brightness.dark ? 0.9 : 0.96,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.08),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            theme.brightness == Brightness.dark ? 0.16 : 0.05,
                          ),
                          blurRadius: 28,
                          spreadRadius: -10,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withOpacity(0.16),
                                theme.colorScheme.secondary.withOpacity(0.12),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(
                            item.isRead
                                ? Icons.notifications_none_rounded
                                : Icons.notifications_active_rounded,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  if (!item.isRead)
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(item.subtitle),
                              const SizedBox(height: 10),
                              Text(
                                AppFormatters.formatDate(item.date),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.textTheme.bodySmall?.color
                                      ?.withOpacity(0.7),
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
            }),
          ],
        ),
      ),
    );
  }
}
