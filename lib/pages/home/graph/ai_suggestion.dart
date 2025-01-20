import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';

class AiSuggestion extends StatefulWidget {
  const AiSuggestion({super.key});

  @override
  _AiSuggestionState createState() => _AiSuggestionState();
}

class _AiSuggestionState extends State<AiSuggestion> {
  String _displayedText = "";
  final String _fullText =
      "Your health is your greatest wealth, and we're here to help you make smarter choices every day.";
  int _currentIndex = 0;
  bool _isLoading = true;
  Timer? _loadingTimer;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _loadingTimer = Timer(Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _startTypingEffect();
      }
    });
  }

  void _startTypingEffect() {
    _typingTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_currentIndex < _fullText.length) {
        if (mounted) {
          setState(() {
            _displayedText += _fullText[_currentIndex];
            _currentIndex++;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorManager.bluePrimary, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.smart_toy, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                "AI Suggestions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: _isLoading
                ? Row(
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Analyzing...",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                : Text(
                    _displayedText,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ),
          Spacer(),
          Container(
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: TextButton.icon(
              icon: Image.asset(
                "assets/image/gen/gen-logo.png",
                width: 25,
                height: 25,
                color: ColorManager.bluePrimary,
              ),
              onPressed: () {},
              label: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [ColorManager.bluePrimary, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  "Ask AI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
