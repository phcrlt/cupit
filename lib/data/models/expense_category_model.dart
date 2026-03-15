import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryModel extends Equatable {
  const ExpenseCategoryModel({
    required this.title,
    required this.amount,
    required this.colorHex,
  });

  final String title;
  final double amount;
  final int colorHex;

  Color get color => Color(colorHex);

  @override
  List<Object> get props => [title, amount, colorHex];
}
