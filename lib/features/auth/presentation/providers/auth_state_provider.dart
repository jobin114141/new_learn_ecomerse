import 'package:my_ecomerse/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthStatus build() {
    _checkAuthStatus();
    return AuthStatus.initial;
  }

  Future<void> _checkAuthStatus() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final token = await tokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  void setAuthenticated() {
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    await tokenStorage.clearToken();
    state = AuthStatus.unauthenticated;
  }
}
