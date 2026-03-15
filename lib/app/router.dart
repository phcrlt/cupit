import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/action_flow_screen.dart';
import '../presentation/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/menu_sections/menu_section_screen.dart';
import '../presentation/screens/notifications/notifications_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => _buildPage(
            state: state,
            child: const DashboardScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => _buildPage(
            state: state,
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/notifications',
          pageBuilder: (context, state) => _buildPage(
            state: state,
            child: const NotificationsScreen(),
          ),
        ),
        GoRoute(
          path: '/actions/:actionId',
          pageBuilder: (context, state) => _buildPage(
            state: state,
            child: ActionFlowScreen(
              actionId: state.pathParameters['actionId'] ?? '',
            ),
          ),
        ),
        GoRoute(
          path: '/sections/:sectionId',
          pageBuilder: (context, state) => _buildPage(
            state: state,
            child: MenuSectionScreen(
              sectionId: state.pathParameters['sectionId'] ?? '',
            ),
          ),
        ),
      ],
    );
  }

  static CustomTransitionPage<void> _buildPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 320),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
