import 'package:chat/widget/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authUSer = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No MEssage Found'),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('something went wrong'),
            );
          }

          final loadedMessage = snapshot.data!.docs;
          return ListView.builder(
              padding: const EdgeInsets.only(left: 13, right: 13, bottom: 40),
              itemCount: loadedMessage.length,
              reverse: true,
              itemBuilder: (ctx, index) {
                final chatMessage = loadedMessage[index].data();
                final nextNessage = index + 1 < loadedMessage.length
                    ? loadedMessage[index + 1].data()
                    : null;

                final currentMessageUserId = chatMessage['userId'];
                final nextMessageUserId =
                    nextNessage != null ? nextNessage['userId'] : null;

                final nextUSerIsSame =
                    nextMessageUserId == currentMessageUserId;

                if (nextUSerIsSame) {
                  return MessageBubble.next(
                      message: chatMessage['text'],
                      isMe: authUSer.uid == currentMessageUserId);
                } else {
                  return MessageBubble.first(
                      userImage: chatMessage['userImage'],
                      username: chatMessage['username'],
                      message: chatMessage['text'],
                      isMe: authUSer.uid == currentMessageUserId);
                }
              });
        });
  }
}
