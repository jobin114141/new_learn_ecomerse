import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

class ChatScreen extends HookWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    
    // Initial mock messages
    final messages = useState<List<ChatMessage>>([
      ChatMessage(
        text: 'Hello! How can we help you today?',
        isMe: false,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        text: 'I have a question about my recent order.',
        isMe: true,
        time: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
    ]);

    void sendMessage() {
      if (textController.text.trim().isEmpty) return;

      messages.value = [
        ...messages.value,
        ChatMessage(
          text: textController.text.trim(),
          isMe: true,
          time: DateTime.now(),
        )
      ];
      textController.clear();
      
      // Scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      
      // Mock reply
      Future.delayed(const Duration(seconds: 1), () {
        messages.value = [
          ...messages.value,
          ChatMessage(
            text: 'Let me check on that for you right away.',
            isMe: false,
            time: DateTime.now(),
          )
        ];
        Future.delayed(const Duration(milliseconds: 100), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.support_agent, color: Colors.blue),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Support Team',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Typically replies in minutes',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.value.length,
                itemBuilder: (context, index) {
                  final message = messages.value[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
            _buildMessageInput(textController, sendMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: message.isMe ? const Radius.circular(0) : const Radius.circular(20),
            bottomLeft: !message.isMe ? const Radius.circular(0) : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: const BoxConstraints(maxWidth: 280),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isMe ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(TextEditingController controller, VoidCallback onSend) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.grey),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 18),
              onPressed: onSend,
            ),
          ),
        ],
      ),
    );
  }
}
