import '../repositories/chat_message_repository.dart';
import '../../data/models/chat_message_model.dart';

class GetMessagesUseCase {
  final ChatMessageRepository _repository;
  GetMessagesUseCase(this._repository);
  Stream<ChatMessageModel> execute() {
    return _repository.getMessageStream();
  }
}
