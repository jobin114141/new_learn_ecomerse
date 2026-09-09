import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_client.dart';
import '../storage/token_storage.dart';

part 'api_client_provider.g.dart';

/// Centralized ApiClient provider accessible across all features
@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

/// Centralized TokenStorage provider
@riverpod
TokenStorage tokenStorage(Ref ref) {
  return TokenStorage();
}
