import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  const CardModel({
    required this.id,
    required this.title,
    required this.balance,
    required this.maskedNumber,
    required this.holderName,
  });

  final String id;
  final String title;
  final double balance;
  final String maskedNumber;
  final String holderName;

  CardModel copyWith({
    String? id,
    String? title,
    double? balance,
    String? maskedNumber,
    String? holderName,
  }) {
    return CardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      balance: balance ?? this.balance,
      maskedNumber: maskedNumber ?? this.maskedNumber,
      holderName: holderName ?? this.holderName,
    );
  }

  @override
  List<Object> get props => [id, title, balance, maskedNumber, holderName];
}
