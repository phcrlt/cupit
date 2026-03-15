import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_banking_app/app/app.dart';
import 'package:mobile_banking_app/core/services/local_storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dashboard renders banking content', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await initializeDateFormatting('ru_RU');

    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorageService = LocalStorageService(
      sharedPreferences: sharedPreferences,
    );

    await tester.pumpWidget(
      BankingApp(localStorageService: localStorageService),
    );
    await tester.pumpAndSettle();

    expect(find.text('Главная'), findsOneWidget);
    expect(find.text('Быстрые действия'), findsOneWidget);
    expect(find.text('Последние операции'), findsOneWidget);
  });
}
