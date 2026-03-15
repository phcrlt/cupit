import '../../data/models/notification_model.dart';

class MockNotificationService {
  Future<List<NotificationModel>> fetchNotifications() async {
    return [
      NotificationModel(
        id: 'notification_1',
        title: 'Квитанция за ЖКУ готова',
        subtitle: 'Оплатите до 25 числа без комиссии',
        date: DateTime(2026, 3, 14),
        isRead: false,
      ),
      NotificationModel(
        id: 'notification_2',
        title: 'Кэшбэк начислен',
        subtitle: 'На карту зачислено 1 240 ₽',
        date: DateTime(2026, 3, 13),
        isRead: true,
      ),
      NotificationModel(
        id: 'notification_3',
        title: 'Напоминание о путешествии',
        subtitle: 'Проверьте страхование перед поездкой',
        date: DateTime(2026, 3, 12),
        isRead: true,
      ),
      NotificationModel(
        id: 'notification_4',
        title: 'Подборка выгодных предложений обновлена',
        subtitle: 'Новые скидки на транспорт, связь и путешествия',
        date: DateTime(2026, 3, 11),
        isRead: false,
      ),
      NotificationModel(
        id: 'notification_5',
        title: 'Накопительный счет вырос',
        subtitle: 'Доход за неделю составил 2 180 ₽',
        date: DateTime(2026, 3, 10),
        isRead: true,
      ),
    ];
  }
}
