import '../../data/models/card_model.dart';

class MockCardService {
  Future<List<CardModel>> fetchCards() async {
    return [
      const CardModel(
        id: 'card_main',
        title: 'Основная карта',
        balance: 184250,
        maskedNumber: '**** 4589',
        holderName: 'Алексей Смирнов',
      ),
      const CardModel(
        id: 'card_travel',
        title: 'Карта для поездок',
        balance: 96240,
        maskedNumber: '**** 1084',
        holderName: 'Алексей Смирнов',
      ),
      const CardModel(
        id: 'card_savings',
        title: 'Накопительный счет',
        balance: 420500,
        maskedNumber: '**** 7741',
        holderName: 'Алексей Смирнов',
      ),
    ];
  }
}
