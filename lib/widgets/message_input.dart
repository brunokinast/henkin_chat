import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  @override
  MessageInputState createState() => MessageInputState();
}

class MessageInputState extends State<MessageInput> {
  final _inputController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendMessage() async {
    if (_inputController.text.trim().isNotEmpty) {
      setState(() => _isSending = true);

      final message = _inputController.text;
      _inputController.clear();

      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();
      await FirebaseFirestore.instance.collection('chat').add({
        'text': message,
        'userID': userUid,
        'timestamp': Timestamp.now(),
        'name': userData.get('name'),
        'color': userData.get('color'),
      });
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              minLines: 1,
              maxLines: 3,
              controller: _inputController,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.send,
              onEditingComplete: _sendMessage,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                hintText: 'Digite uma mensagem...',
              ),
            ),
          ),
          _isSending
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: FittedBox(child: CircularProgressIndicator()),
                )
              : IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryIconTheme.color,
                  disabledColor: Theme.of(context)
                      .primaryIconTheme
                      .color!
                      .withOpacity(0.5),
                  onPressed: _inputController.text.trim().isEmpty
                      ? null
                      : _sendMessage,
                ),
        ],
      ),
    );
  }
}
