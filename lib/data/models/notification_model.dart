import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isRead,
  });

  final String id;
  final String title;
  final String subtitle;
  final DateTime date;
  final bool isRead;

  NotificationModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    DateTime? date,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object> get props => [id, title, subtitle, date, isRead];
}
