import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceAssistantChatFast extends StatefulWidget {
  const VoiceAssistantChatFast({Key? key}) : super(key: key);

  @override
  _VoiceAssistantChatFastState createState() => _VoiceAssistantChatFastState();
}

class _VoiceAssistantChatFastState extends State<VoiceAssistantChatFast> {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;

  bool _isListening = false;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> _chatHistory = [];

  Timer? _speechTimeout;
  final int _timeoutSeconds = 3; // stop after 3 seconds of silence

  @override
  void initState() {
    super.initState();

    _speech = stt.SpeechToText();
    _initSpeech();

    _flutterTts = FlutterTts();
    _initTts();
  }

  Future<void> _initSpeech() async {
    await _speech.initialize();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.8);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.awaitSpeakCompletion(true);
  }

  void _listen() async {
    if (!_isListening) {
      if (_speech.isAvailable) {
        setState(() => _isListening = true);

        _speech.listen(
          onResult: (val) {
            String recognized = val.recognizedWords;
            if (recognized.isNotEmpty) {
              if (_chatHistory.isEmpty || _chatHistory.last['sender'] != 'user') {
                _chatHistory.add({'sender': 'user', 'message': recognized});
              } else {
                _chatHistory.last['message'] = recognized;
              }
              setState(() {});
              _scrollToBottom();

              // Reset timer when user speaks
              _speechTimeout?.cancel();
              _speechTimeout =
                  Timer(Duration(seconds: _timeoutSeconds), _stopListeningAutomatically);
            }
          },
          listenMode: stt.ListenMode.dictation,
          partialResults: true,
        );
      }
    } else {
      // toggle stop when button is pressed again
      _stopListeningAutomatically();
    }
  }

  void _stopListeningAutomatically() {
    if (!_isListening) return;

    _speech.stop();
    setState(() => _isListening = false);
    _speechTimeout?.cancel();
    _processUserMessage();
  }

  void _processUserMessage() {
    String userMessage = _chatHistory.isNotEmpty
        ? _chatHistory.last['message']?.trim() ?? ''
        : '';

    if (userMessage.isEmpty) {
      setState(() {
        _chatHistory.add({'sender': 'bot', 'message': 'You did not say anything.'});
      });
      _flutterTts.speak('You did not say anything.');
      _scrollToBottom();
      return;
    }

    String botReply = _getReply(userMessage);

    _flutterTts.speak(botReply);

    setState(() {
      _chatHistory.add({'sender': 'bot', 'message': botReply});
    });

    _scrollToBottom();
  }

  String _getReply(String input) {
    final message = input.toLowerCase();

    if (message.contains('hello') || message.contains('hi')) {
      return 'Hello Farmer! How can I help you today?';
    } else if (message.contains('weather')) {
      return 'Today is sunny with a high chance of rain in the evening.';
    } else if (message.contains('crop') || message.contains('prediction')) {
      return 'Your wheat crop is expected to yield 20% more this season.';
    } else if (message.contains('government') || message.contains('scheme')) {
      return 'You are eligible for the PM-Kisan scheme. Would you like details?';
    } else if (message.contains('thank')) {
      return 'You are welcome!';
    } else {
      return 'Sorry, I didn\'t understand that. Can you please repeat?';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildChatBubble(Map<String, String> msg) {
    bool isUser = msg['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isUser ? Colors.green[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg['message'] ?? '',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Assistant")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                return _buildChatBubble(_chatHistory[index]);
              },
            ),
          ),
          const SizedBox(height: 8),
          IconButton(
            iconSize: 70,
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: Colors.green,
            ),
            onPressed: _listen,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _speech.stop();
    _flutterTts.stop();
    _speechTimeout?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
}
