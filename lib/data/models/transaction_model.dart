import 'package:equatable/equatable.dart';

enum TransactionType {
  food,
  transport,
  entertainment,
  income,
  other,
}

class TransactionModel extends Equatable {
  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  bool get isIncome => amount >= 0;

  @override
  List<Object> get props => [id, title, amount, date, type];
}
