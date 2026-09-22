import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/features/chat/data/models/chat_message_model.dart';
import 'package:my_ecomerse/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:my_ecomerse/features/chat/domain/repositories/chat_message_repository.dart';
import 'package:my_ecomerse/features/chat/domain/use_case/get_messages_use_case.dart';
import 'package:my_ecomerse/features/chat/domain/use_case/send_message_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

@riverpod
ChatMessageRepository chatRepository(Ref ref) {
  final repo = ChatRepositoryImpl();
  ref.onDispose(() => repo.disconnect());
  return repo;
}

@riverpod
GetMessagesUseCase getMessagesUseCase(Ref ref) {
  return GetMessagesUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
SendMessageUseCase sendMessageUseCase(Ref ref) {
  return SendMessageUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
class ChatNotifier extends _$ChatNotifier {
  StreamSubscription? _subscription;
  @override
  List<ChatMessageModel> build() {
    final useCase = ref.read(getMessagesUseCaseProvider);
    
    // Listen to the endless Stream
    _subscription = useCase.execute().listen(
      (newMessage) {
        state = [...state, newMessage];
      },
      // Without this, a WebSocket error crashes the entire widget tree!
      onError: (error) {
        // Silently ignore errors - the UI stays alive
        print('[ChatNotifier] WebSocket error: $error');
      },
      onDone: () {
        print('[ChatNotifier] WebSocket connection closed.');
      },
      cancelOnError: false, // Keep the subscription alive even if an error occurs
    );
    
    ref.onDispose(() => _subscription?.cancel());
    return [];
  }
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    // Instantly update our UI state
    state = [...state, ChatMessageModel(text: text, isMe: true)];
    // Send it to the server
    ref.read(sendMessageUseCaseProvider).execute(text);
  }
}
