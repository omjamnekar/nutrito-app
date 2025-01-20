import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:uuid/uuid.dart';

class ChatSection extends StatefulWidget {
  const ChatSection({super.key});

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  final List<Message> _messages = [];
  final ChatUser _user = ChatUser(id: 'user-1', name: 'User');
  final ChatUser _bot = ChatUser(id: 'bot-1', name: 'Bot');

  void _handleSendPressed(String messageText) {
    final message = Message(
      id: const Uuid().v4(),
      message: messageText,
      createdAt: DateTime.now(),
      sentBy: _user.id,
    );

    setState(() {
      _messages.insert(0, message);
    });

    // Simulate bot reply
    Future.delayed(const Duration(seconds: 1), () {
      final botReply = Message(
        id: const Uuid().v4(),
        message: 'You said: $messageText',
        createdAt: DateTime.now(),
        sentBy: _bot.id,
      );

      setState(() {
        _messages.insert(0, botReply);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChatView(
      // messages: _messages,
      onSendTap: (message, replyMessage, messageType) =>
          _handleSendPressed(message),
      chatBackgroundConfig: ChatBackgroundConfiguration(
        backgroundColor: const Color.fromARGB(255, 224, 251, 246),
      ),
      chatController: ChatController(
        initialMessageList: _messages,
        scrollController: ScrollController(),
        otherUsers: [_bot],
        currentUser: _user,
      ),
      chatViewState: ChatViewState.hasMessages,
    );
  }
}
