import '../../core/services/mock_notification_service.dart';
import '../models/notification_model.dart';

class MockNotificationRepository {
  MockNotificationRepository(this._service);

  final MockNotificationService _service;

  Future<List<NotificationModel>> getNotifications() {
    return _service.fetchNotifications();
  }
}
