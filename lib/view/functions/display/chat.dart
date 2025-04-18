import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  String? _sessionId;
  bool isLoading = false;

  final dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASEURL'] ??
        "https://nutrito-prompt-server-muot.vercel.app",
    headers: {"Content-Type": "application/json"},
  ));

  @override
  void initState() {
    super.initState();
    startSession().then((id) => _sessionId = id);
  }

  Future<String> startSession() async {
    final res = await dio.post("/start_session");
    return res.data["session_id"];
  }

  Future<String> sendMessage(String sessionId, String message) async {
    try {
      final res = await dio.post("/send_message", data: {
        "session_id": sessionId,
        "message": message,
      });
      return res.data["response"];
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      return "Oops! Something went wrong.";
    }
  }

  Future<void> endSession(String sessionId) async {
    await dio.post(
      "/end_session",
      data: {"session_id": sessionId},
    );
  }

  void handleSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sessionId == null) return;

    setState(() {
      messages.add({"sender": "user", "text": text});
      _controller.clear();
      isLoading = true;
    });

    final botReply = await sendMessage(_sessionId!, text);

    setState(() {
      messages.add({"sender": "bot", "text": botReply});
      isLoading = false;
    });
  }

  @override
  void dispose() {
    if (_sessionId != null) {
      endSession(_sessionId!);
    }
    _controller.dispose();
    super.dispose();
  }

  Widget buildMessage(Map<String, String> msg) {
    final isUser = msg["sender"] == "user";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        padding: const EdgeInsets.all(12),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isUser ? ColorManager.bluePrimary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: isUser
            ? Text(
                msg["text"]!,
                style: TextStyle(color: Colors.white),
              )
            : MarkdownBody(
                data: msg["text"]!,
                styleSheet:
                    MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: TextStyle(color: Colors.black87),
                ),
              ),
      ),
    );
  }

  Widget buildThinkingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        padding: const EdgeInsets.all(12),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 14,
            width: 100,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  bool isMessageInitial = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Nutrito AI"),
        backgroundColor: Colors.white,
        shadowColor: ColorManager.bluePrimary,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: const Color.fromARGB(160, 0, 221, 181),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          isMessageInitial
              ? Expanded(
                  child: ListView.builder(
                    itemCount: messages.length + (isLoading ? 1 : 0),
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      if (index == messages.length && isLoading) {
                        return buildThinkingBubble();
                      }
                      return buildMessage(messages[index]);
                    },
                  ),
                )
              : WelcomeScreen(
                  onClick: (message) {
                    _controller.text = message;
                    handleSend();
                    setState(() {
                      isMessageInitial = !isMessageInitial;
                    });
                  },
                ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => handleSend(),
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: handleSend,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  Function(String message) onClick;
  WelcomeScreen({super.key, required this.onClick});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "What can I help with?",
                style: TextStyle(
                  fontSize: 30,
                  color: ColorManager.bluePrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  _buildOption("Health improve", Icons.image, Colors.green, () {
                    widget.onClick(
                        "can you provide me info for how i can improve my health with all stuff that i can do to improve it");
                  }),
                  _buildOption(
                    "Diet",
                    Icons.auto_awesome,
                    Colors.cyan,
                    () {
                      widget.onClick(
                          "Provide me base guidance for diet and help me with asking question");
                    },
                  ),
                  _buildOption(
                    "Plan for Gym",
                    Icons.lightbulb,
                    Colors.yellow,
                    () {
                      widget.onClick(
                          "Provide me base guidance for plan Gym and help me with asking question");
                    },
                  ),
                  _buildOption("Nutritionist ", Icons.code, Colors.purpleAccent,
                      () {
                    widget.onClick(
                        "Provide me base info for Nutrition with be Nutritionist and help me with asking question");
                  }),
                  _buildOption(
                    "More",
                    Icons.more_horiz,
                    Colors.grey,
                    () {
                      widget.onClick(
                          "can you tell me how many things you can help me with health related stuff");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
      String label, IconData icon, Color iconColor, Function() onInnerClick) {
    return ElevatedButton.icon(
      onPressed: () {
        onInnerClick();
      },
      icon: Icon(icon, color: iconColor),
      label: Text(
        label,
        style: GoogleFonts.poppins(color: Colors.black54),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
