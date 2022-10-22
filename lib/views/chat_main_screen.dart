import 'package:henkin_chat/widgets/dropdown_menu.dart';
import 'package:henkin_chat/widgets/message_input.dart';
import 'package:henkin_chat/widgets/messages.dart';
import 'package:flutter/material.dart';

class ChatMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HenkinChat'),
        actions: [DropdownMenu()],
      ),
      body: Column(
        children: [
          Expanded(child: Messages()),
          MessageInput(),
        ],
      ),
    );
  }
}
