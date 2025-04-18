import 'package:flutter/material.dart';

class GenChatPage extends StatelessWidget {
  const GenChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gen Chat'),
      ),
      body: Center(
        child: Text('Welcome to Gen Chat!'),
      ),
    );
  }
}
