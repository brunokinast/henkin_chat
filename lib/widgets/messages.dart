import 'dart:async';

import 'package:henkin_chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final fb = snapshot.data!;
          bool needsScroll = true;
          return ListView.builder(
            controller: scrollController,
            itemCount: fb.size,
            itemBuilder: (context, i) {
              if (needsScroll) {
                Timer(
                  const Duration(milliseconds: 300),
                  () {
                    if (scrollController.hasClients)
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent + 5,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                  },
                );
                needsScroll = false;
              }
              return MessageBubble(
                fb.docs[i],
                fb.docs[i].get('userID') ==
                    FirebaseAuth.instance.currentUser!.uid,
                ValueKey(fb.docs[i].id),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
