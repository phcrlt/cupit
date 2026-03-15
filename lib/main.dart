import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU');

  final sharedPreferences = await SharedPreferences.getInstance();
  final localStorageService =
      LocalStorageService(sharedPreferences: sharedPreferences);

  runApp(BankingApp(localStorageService: localStorageService));
}
