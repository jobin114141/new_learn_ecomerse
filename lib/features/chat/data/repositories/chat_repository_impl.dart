import 'package:my_ecomerse/features/chat/data/models/chat_message_model.dart';
import 'package:my_ecomerse/features/chat/domain/repositories/chat_message_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRepositoryImpl implements ChatMessageRepository {
  WebSocketChannel? _channel;
  // ✅ FIX: Connect lazily only when the stream is first listened to
  ChatRepositoryImpl(); // Empty constructor

  void _ensureConnected() {
    _channel ??= WebSocketChannel.connect(
      Uri.parse('wss://ws.postman-echo.com/raw'), // Working echo server
    );
  }

  @override
  Stream<ChatMessageModel> getMessageStream() {
    _ensureConnected(); // Connect only when stream is actually needed
    return _channel!.stream.map((incomingData) {
      return ChatMessageModel(text: incomingData.toString(), isMe: false);
    });
  }

  @override
  void sendMessage(String text) {
    _ensureConnected();
    _channel?.sink.add(text);
  }

  @override
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}
