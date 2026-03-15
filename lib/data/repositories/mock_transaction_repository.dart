import '../../core/services/mock_transaction_service.dart';
import '../models/expense_category_model.dart';
import '../models/transaction_model.dart';

class MockTransactionRepository {
  MockTransactionRepository(this._service);

  final MockTransactionService _service;

  Future<List<TransactionModel>> getTransactions() {
    return _service.fetchTransactions();
  }

  Future<List<ExpenseCategoryModel>> getExpenseCategories() {
    return _service.fetchExpenseCategories();
  }
}
