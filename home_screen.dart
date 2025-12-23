import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/chat_widget.dart';
import '../widgets/voice_button.dart';
import '../widgets/tools_grid.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const ChatScreen(),
    const ToolsGrid(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IA Experta SIG'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<SettingsProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<SettingsProvider>(context, listen: false)
                  .toggleDarkMode();
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Herramientas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ChatWidget(
            chatProvider: Provider.of<ChatProvider>(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: Provider.of<ChatProvider>(context, listen: false)
                      .messageController,
                  decoration: const InputDecoration(
                    hintText: 'Escribe tu pregunta...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendMessage(value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              VoiceButton(
                onPressed: () {
                  Provider.of<ChatProvider>(context, listen: false)
                      .toggleListening();
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final message = Provider.of<ChatProvider>(context,
                          listen: false)
                      .messageController
                      .text;
                  if (message.trim().isNotEmpty) {
                    Provider.of<ChatProvider>(context, listen: false)
                        .sendMessage(message);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}