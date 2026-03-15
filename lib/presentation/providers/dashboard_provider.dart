import 'package:flutter/foundation.dart';

import '../../data/models/card_model.dart';
import '../../data/models/expense_category_model.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repositories/mock_card_repository.dart';
import '../../data/repositories/mock_transaction_repository.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider({
    required MockCardRepository cardRepository,
    required MockTransactionRepository transactionRepository,
  })  : _cardRepository = cardRepository,
        _transactionRepository = transactionRepository;

  final MockCardRepository _cardRepository;
  final MockTransactionRepository _transactionRepository;

  bool _isLoading = false;
  List<CardModel> _cards = [];
  List<TransactionModel> _transactions = [];
  List<ExpenseCategoryModel> _expenseCategories = [];
  int _transactionCounter = 100;

  bool get isLoading => _isLoading;
  List<CardModel> get cards => _cards;
  List<TransactionModel> get transactions => _transactions;
  List<ExpenseCategoryModel> get expenseCategories => _expenseCategories;
  double get totalBalance =>
      _cards.fold<double>(0, (sum, card) => sum + card.balance);
  double get monthlyIncome => _transactions
      .where((transaction) => transaction.isIncome)
      .fold<double>(0, (sum, transaction) => sum + transaction.amount);
  double get monthlyExpenses => _transactions
      .where((transaction) => !transaction.isIncome)
      .fold<double>(0, (sum, transaction) => sum + transaction.amount.abs());
  List<String> get financialTips {
    final tips = <String>[
      'Попробуйте перевести часть свободных средств на накопительный счет, чтобы деньги работали без лишних действий.',
      'Расходы на транспорт заметны в этом месяце. Можно заранее пополнять проездной и снизить спонтанные траты.',
    ];

    if (monthlyExpenses > monthlyIncome * 0.7 && monthlyIncome > 0) {
      tips.insert(
        0,
        'Расходы приблизились к 70% дохода. Стоит поставить мягкий лимит на ежедневные покупки.',
      );
    }

    if (_transactions.any((transaction) => transaction.type == TransactionType.entertainment)) {
      tips.add(
        'Развлечения уже занимают заметную долю расходов. Можно сохранить часть бюджета на конец месяца.',
      );
    }

    return tips.take(3).toList();
  }

  Future<void> loadDashboard() async {
    _isLoading = true;
    notifyListeners();

    _cards = await _cardRepository.getCards();
    _transactions = await _transactionRepository.getTransactions();
    _sortTransactions();
    _expenseCategories = _buildExpenseCategories(_transactions);

    _isLoading = false;
    notifyListeners();
  }

  List<TransactionModel> transactionsByTypes(List<TransactionType> types) {
    if (types.isEmpty) {
      return _transactions.take(4).toList();
    }

    final matches = _transactions
        .where((transaction) => types.contains(transaction.type))
        .toList();

    if (matches.isEmpty) {
      return _transactions.take(4).toList();
    }

    return matches.take(4).toList();
  }

  CardModel? cardById(String cardId) {
    for (final card in _cards) {
      if (card.id == cardId) {
        return card;
      }
    }

    return null;
  }

  bool hasEnoughBalance(String cardId, double amount) {
    final card = cardById(cardId);
    if (card == null) {
      return false;
    }

    return card.balance >= amount;
  }

  Future<TransactionModel> topUp({
    required String cardId,
    required double amount,
    required String source,
    String? note,
  }) async {
    _updateCardBalance(cardId, amount);
    final transaction = _prependTransaction(
      title: 'Пополнение: $source',
      amount: amount,
      type: TransactionType.income,
      note: note,
    );
    return transaction;
  }

  Future<TransactionModel> pay({
    required String cardId,
    required double amount,
    required String target,
    String? note,
  }) async {
    _updateCardBalance(cardId, -amount);
    final transaction = _prependTransaction(
      title: target,
      amount: -amount,
      type: _resolveTransactionType(target),
      note: note,
    );
    return transaction;
  }

  Future<TransactionModel> transfer({
    required String cardId,
    required double amount,
    required String recipient,
    String? note,
  }) async {
    _updateCardBalance(cardId, -amount);
    final transaction = _prependTransaction(
      title: 'Перевод: $recipient',
      amount: -amount,
      type: TransactionType.other,
      note: note,
    );
    return transaction;
  }

  TransactionModel _prependTransaction({
    required String title,
    required double amount,
    required TransactionType type,
    String? note,
  }) {
    final transactionTitle =
        note == null || note.trim().isEmpty ? title : '$title · ${note.trim()}';
    final transaction = TransactionModel(
      id: 'transaction_${_transactionCounter++}',
      title: transactionTitle,
      amount: amount,
      date: DateTime.now(),
      type: type,
    );

    _transactions = [transaction, ..._transactions];
    _sortTransactions();
    _expenseCategories = _buildExpenseCategories(_transactions);
    notifyListeners();
    return transaction;
  }

  void _updateCardBalance(String cardId, double delta) {
    _cards = _cards
        .map(
          (card) => card.id == cardId
              ? card.copyWith(balance: card.balance + delta)
              : card,
        )
        .toList();
  }

  void _sortTransactions() {
    _transactions.sort((left, right) => right.date.compareTo(left.date));
  }

  List<ExpenseCategoryModel> _buildExpenseCategories(
    List<TransactionModel> transactions,
  ) {
    final totals = <TransactionType, double>{
      TransactionType.food: 0,
      TransactionType.transport: 0,
      TransactionType.entertainment: 0,
      TransactionType.other: 0,
    };

    for (final transaction in transactions) {
      if (transaction.isIncome) {
        continue;
      }

      final currentTotal = totals[transaction.type];
      if (currentTotal == null) {
        totals[TransactionType.other] =
            (totals[TransactionType.other] ?? 0) + transaction.amount.abs();
        continue;
      }

      totals[transaction.type] = currentTotal + transaction.amount.abs();
    }

    final allExpenses = totals.values.fold<double>(0, (sum, value) => sum + value);
    if (allExpenses == 0) {
      return const [];
    }

    return [
      ExpenseCategoryModel(
        title: 'Еда',
        amount: _resolvePercent(totals[TransactionType.food]!, allExpenses),
        colorHex: 0xFF4B7BFF,
      ),
      ExpenseCategoryModel(
        title: 'Транспорт',
        amount: _resolvePercent(totals[TransactionType.transport]!, allExpenses),
        colorHex: 0xFF3ED3A1,
      ),
      ExpenseCategoryModel(
        title: 'Развлечения',
        amount: _resolvePercent(
          totals[TransactionType.entertainment]!,
          allExpenses,
        ),
        colorHex: 0xFFFFB84D,
      ),
      ExpenseCategoryModel(
        title: 'Другое',
        amount: _resolvePercent(totals[TransactionType.other]!, allExpenses),
        colorHex: 0xFFE66A8D,
      ),
    ];
  }

  double _resolvePercent(double value, double total) {
    if (total == 0) {
      return 0;
    }

    return double.parse(((value / total) * 100).toStringAsFixed(1));
  }

  TransactionType _resolveTransactionType(String target) {
    final value = target.toLowerCase();
    if (value.contains('кафе') || value.contains('еда')) {
      return TransactionType.food;
    }
    if (value.contains('такси') ||
        value.contains('транспорт') ||
        value.contains('азс') ||
        value.contains('связь')) {
      return TransactionType.transport;
    }
    if (value.contains('кино') ||
        value.contains('концерт') ||
        value.contains('путеше')) {
      return TransactionType.entertainment;
    }
    return TransactionType.other;
  }
}
