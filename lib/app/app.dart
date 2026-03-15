import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/services/local_storage_service.dart';
import '../core/services/mock_card_service.dart';
import '../core/services/mock_notification_service.dart';
import '../core/services/mock_transaction_service.dart';
import '../core/themes/dark_theme.dart';
import '../core/themes/light_theme.dart';
import '../core/themes/theme_provider.dart';
import '../data/repositories/mock_card_repository.dart';
import '../data/repositories/mock_notification_repository.dart';
import '../data/repositories/mock_transaction_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../presentation/providers/dashboard_provider.dart';
import '../presentation/providers/notification_provider.dart';
import '../presentation/providers/profile_provider.dart';
import 'router.dart';

class BankingApp extends StatelessWidget {
  BankingApp({
    super.key,
    required LocalStorageService localStorageService,
  })  : _localStorageService = localStorageService,
        _router = AppRouter.createRouter();

  final LocalStorageService _localStorageService;
  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    final cardRepository = MockCardRepository(MockCardService());
    final transactionRepository =
        MockTransactionRepository(MockTransactionService());
    final notificationRepository =
        MockNotificationRepository(MockNotificationService());
    final profileRepository = ProfileRepository(_localStorageService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(_localStorageService)..loadTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(
            cardRepository: cardRepository,
            transactionRepository: transactionRepository,
          )..loadDashboard(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(
            notificationRepository: notificationRepository,
          )..loadNotifications(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(profileRepository: profileRepository)
            ..loadProfile(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Банк',
            debugShowCheckedModeBanner: false,
            theme: buildLightTheme(
              themeProvider.palette,
              themeProvider.accent,
            ),
            darkTheme: buildDarkTheme(
              themeProvider.palette,
              themeProvider.accent,
            ),
            themeMode: themeProvider.themeMode,
            routerConfig: _router,
            locale: const Locale('ru', 'RU'),
            supportedLocales: const [
              Locale('ru', 'RU'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
