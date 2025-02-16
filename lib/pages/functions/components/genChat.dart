import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatSection extends ConsumerWidget {
  const ChatSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);

    if (messages.first.message.isNotEmpty) {
      return ChatView(
        onSendTap: (message, replyMessage, messageType) {
          chatNotifier.addMessage(message); // Add user message to state
          chatNotifier.fetchBotReply(message); // Fetch bot reply from API
        },
        chatBackgroundConfig: ChatBackgroundConfiguration(
          backgroundColor: const Color.fromARGB(255, 224, 251, 246),
        ),
        chatController: ChatController(
          initialMessageList: messages,
          scrollController: ScrollController(),
          currentUser: ChatUser(id: 'user-1', name: 'User'),
          otherUsers: [ChatUser(id: 'bot-1', name: 'GenAi')],
        ),
        messageConfig: MessageConfiguration(),
        chatViewState: messages.isNotEmpty
            ? ChatViewState.hasMessages
            : ChatViewState.noData,
      );
    } else {
      return Container();
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<Message>>(
  (ref) => ChatNotifier(),
);

class ChatNotifier extends StateNotifier<List<Message>> {
  ChatNotifier()
      : super([
          Message(
            id: const Uuid().v4(),
            message: "Ask about nutrition and health.",
            createdAt: DateTime.now(),
            sentBy: "NutriGen",
          ),
        ]);

  final ChatUser _user = ChatUser(id: 'user-1', name: 'User');
  final ChatUser _bot = ChatUser(id: 'bot-1', name: 'GenAi');

  /// Add user message to the chat state
  void addMessage(String text) {
    final userMessage = Message(
      id: const Uuid().v4(),
      message: text,
      createdAt: DateTime.now(),
      sentBy: _user.id,
    );

    state = [userMessage, ...state];
  }

  /// Fetch bot reply from the Gemini API using the google_generative_ai package
  Future<void> fetchBotReply(String userMessage) async {
    try {
      // Load environment variables
      await dotenv.load();
      final apiKey = dotenv.get("GENIAPI");

      // Initialize the generative model
      final model = GenerativeModel(
        model: 'gemini-2.0-flash-exp', // Model version
        apiKey: apiKey, // API key from environment variable
        generationConfig: GenerationConfig(
          temperature: 1,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 8192,
          responseMimeType: 'text/plain',
        ),
      );

      // Start the chat with an empty history
      final chat = model.startChat(history: []);

      // Create content to send as the user's message
      final content = Content.text(userMessage);

      // Send message and wait for response
      final response = await chat.sendMessage(content);

      // Create bot reply message
      final botReply = Message(
        id: const Uuid().v4(),
        message: response.text ?? "", // Bot response text
        createdAt: DateTime.now(),
        sentBy: _bot.id,
      );

      // Add bot reply to state
      state = [botReply, ...state];
    } catch (e) {
      final errorMessage = Message(
        id: const Uuid().v4(),
        message: 'Error: Unable to fetch reply. Please try again later.',
        createdAt: DateTime.now(),
        sentBy: _bot.id,
      );

      // Add error message to state
      state = [errorMessage, ...state];
    }
  }
}
