import '../../data/models/chat_message_model.dart';

abstract class ChatMessageRepository {
  Stream<ChatMessageModel> getMessageStream();
  void sendMessage(String text);
  void disconnect();
}
