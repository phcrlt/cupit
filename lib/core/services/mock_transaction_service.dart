import '../../data/models/expense_category_model.dart';
import '../../data/models/transaction_model.dart';

class MockTransactionService {
  Future<List<TransactionModel>> fetchTransactions() async {
    return [
      TransactionModel(
        id: 'transaction_1',
        title: 'Супермаркет',
        amount: -3240,
        date: DateTime(2026, 3, 14),
        type: TransactionType.food,
      ),
      TransactionModel(
        id: 'transaction_2',
        title: 'Такси',
        amount: -890,
        date: DateTime(2026, 3, 13),
        type: TransactionType.transport,
      ),
      TransactionModel(
        id: 'transaction_3',
        title: 'Онлайн-кинотеатр',
        amount: -599,
        date: DateTime(2026, 3, 12),
        type: TransactionType.entertainment,
      ),
      TransactionModel(
        id: 'transaction_4',
        title: 'Зарплата',
        amount: 127500,
        date: DateTime(2026, 3, 11),
        type: TransactionType.income,
      ),
      TransactionModel(
        id: 'transaction_5',
        title: 'Аптека',
        amount: -1280,
        date: DateTime(2026, 3, 10),
        type: TransactionType.other,
      ),
      TransactionModel(
        id: 'transaction_6',
        title: 'АЗС Север',
        amount: -2150,
        date: DateTime(2026, 3, 9),
        type: TransactionType.transport,
      ),
      TransactionModel(
        id: 'transaction_7',
        title: 'Коммунальные услуги',
        amount: -6420,
        date: DateTime(2026, 3, 8),
        type: TransactionType.other,
      ),
      TransactionModel(
        id: 'transaction_8',
        title: 'Кафе у парка',
        amount: -1460,
        date: DateTime(2026, 3, 7),
        type: TransactionType.food,
      ),
      TransactionModel(
        id: 'transaction_9',
        title: 'Концертный зал',
        amount: -3800,
        date: DateTime(2026, 3, 5),
        type: TransactionType.entertainment,
      ),
      TransactionModel(
        id: 'transaction_10',
        title: 'Возврат за билет',
        amount: 2400,
        date: DateTime(2026, 3, 4),
        type: TransactionType.income,
      ),
    ];
  }

  Future<List<ExpenseCategoryModel>> fetchExpenseCategories() async {
    return const [
      ExpenseCategoryModel(title: 'Еда', amount: 42, colorHex: 0xFF4B7BFF),
      ExpenseCategoryModel(
        title: 'Транспорт',
        amount: 21,
        colorHex: 0xFF3ED3A1,
      ),
      ExpenseCategoryModel(
        title: 'Развлечения',
        amount: 18,
        colorHex: 0xFFFFB84D,
      ),
      ExpenseCategoryModel(title: 'Другое', amount: 19, colorHex: 0xFFE66A8D),
    ];
  }
}
