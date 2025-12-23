import 'package:flutter/material.dart';
import '../providers/chat_provider.dart';

class ChatWidget extends StatelessWidget {
  final ChatProvider chatProvider;

  const ChatWidget({super.key, required this.chatProvider});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: chatProvider.messages.length,
      itemBuilder: (context, index) {
        final message = chatProvider.messages[index];
        final isUser = message.sender == 'user';
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isUser
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isUser ? 'Tú' : 'IA Experta',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isUser
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        message.text,
                        style: TextStyle(
                          color: isUser
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        message.timestamp,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: isUser
                              ? Colors.white70
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}