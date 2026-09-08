import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/token_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_repository_provider.g.dart';

// 1. ApiClient Provider
@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

// 2. TokenStorage Provider
@riverpod
TokenStorage tokenStorage(Ref ref) {
  return TokenStorage();
}

// 3. Shared Auth Repository Provider for all Auth Features
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    ref.watch(apiClientProvider),
    ref.watch(tokenStorageProvider),
  );
}
