import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/core/routes/route_name.dart';
import 'package:my_ecomerse/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_ecomerse/features/auth/presentation/screens/otp_login_page.dart';
import 'package:my_ecomerse/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:my_ecomerse/features/splash/presentation/screens/splash_screen.dart';

/// Helper Notifier that bridges Riverpod state changes to GoRouter's refreshListenable
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthStatus>(
      authNotifierProvider,
      (previous, next) => notifyListeners(),
    );
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  final routerNotifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: RouteNames.initial,
    refreshListenable: routerNotifier,
    redirect: (context, state) {
      final authStatus = ref.read(authNotifierProvider);
      final isAuthScreen =
          state.matchedLocation == RouteNames.login ||
          state.matchedLocation == RouteNames.otp;

      switch (authStatus) {
        case AuthStatus.initial:
          return RouteNames.initial; // Stay on Splash screen

        case AuthStatus.unauthenticated:
          return isAuthScreen ? null : RouteNames.login; // Go to Login

        case AuthStatus.authenticated:
          return isAuthScreen ? '/' : null; // Go to Home Screen
      }
    },
    routes: [
      // 1. Splash Screen
      GoRoute(
        path: RouteNames.initial,
        builder: (context, state) => const SplashScreen(),
      ),

      // 2. Phone Login Screen
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // 3. OTP Verification Screen
      GoRoute(
        path: RouteNames.otp,
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          return OtpScreen(phoneNumber: phone);
        },
      ),

      // 4. Home Screen (Root '/')
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home Screen'))),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page Not Found: ${state.error}'))),
  );
});
