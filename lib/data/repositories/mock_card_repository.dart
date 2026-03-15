import '../../core/services/mock_card_service.dart';
import '../models/card_model.dart';

class MockCardRepository {
  MockCardRepository(this._service);

  final MockCardService _service;

  Future<List<CardModel>> getCards() {
    return _service.fetchCards();
  }
}
