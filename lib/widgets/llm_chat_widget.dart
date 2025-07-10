import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wine_app/models/wine.dart';
import 'package:wine_app/providers/wine_provider.dart';

class LLMChatWidget extends StatefulWidget {
  final Wine wine;

  const LLMChatWidget({super.key, required this.wine});

  @override
  State<LLMChatWidget> createState() => _LLMChatWidgetState();
}

class _LLMChatWidgetState extends State<LLMChatWidget> {
  final TextEditingController _questionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add(
      ChatMessage(
        text:
            'Hello! I can help you learn more about ${widget.wine.name}. Ask me anything about this wine!',
        isUser: false,
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat messages
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return _buildMessage(_messages[index]);
            },
          ),
        ),

        // Input area
        _buildInputArea(),
      ],
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isUser) const Spacer(),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.deepPurple : Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
          if (!message.isUser) const Spacer(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Consumer<WineProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    hintText: 'Ask about ${widget.wine.name}...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(provider),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: provider.isAskingLLM
                      ? null
                      : () => _sendMessage(provider),
                  icon: provider.isAskingLLM
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage(WineProvider provider) async {
    final question = _questionController.text.trim();
    if (question.isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(text: question, isUser: true));
    _questionController.clear();
    _scrollToBottom();

    // Get AI response
    await provider.askAboutWine(question);

    if (provider.llmResponse != null) {
      _messages.add(ChatMessage(text: provider.llmResponse!, isUser: false));
      provider.clearLLMResponse();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
