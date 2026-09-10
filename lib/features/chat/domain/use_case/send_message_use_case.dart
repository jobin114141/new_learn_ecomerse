import 'package:my_ecomerse/features/chat/domain/repositories/chat_message_repository.dart';

class SendMessageUseCase {
  final ChatMessageRepository _repository;
  SendMessageUseCase(this._repository);

  void execute(String text) {
    _repository.sendMessage(text);
  }
}
