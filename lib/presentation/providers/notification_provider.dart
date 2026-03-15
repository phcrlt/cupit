import 'package:flutter/foundation.dart';

import '../../data/models/notification_model.dart';
import '../../data/repositories/mock_notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider({
    required MockNotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  final MockNotificationRepository _notificationRepository;

  bool _isLoading = false;
  List<NotificationModel> _notifications = [];

  bool get isLoading => _isLoading;
  List<NotificationModel> get notifications => _notifications;
  int get unreadCount =>
      _notifications.where((notification) => !notification.isRead).length;

  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();
    _notifications = await _notificationRepository.getNotifications();
    _notifications.sort((left, right) => right.date.compareTo(left.date));
    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String notificationId) {
    _notifications = _notifications
        .map(
          (notification) => notification.id == notificationId
              ? notification.copyWith(isRead: true)
              : notification,
        )
        .toList();
    notifyListeners();
  }

  void markAllAsRead() {
    _notifications = _notifications
        .map((notification) => notification.copyWith(isRead: true))
        .toList();
    notifyListeners();
  }

  void pushNotification({
    required String title,
    required String subtitle,
  }) {
    _notifications = [
      NotificationModel(
        id: 'notification_${DateTime.now().microsecondsSinceEpoch}',
        title: title,
        subtitle: subtitle,
        date: DateTime.now(),
        isRead: false,
      ),
      ..._notifications,
    ];
    notifyListeners();
  }
}
