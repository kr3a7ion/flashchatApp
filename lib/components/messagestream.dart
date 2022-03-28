// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'messagebubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  final String firestoreDocumentId = 'messages';
  final String ?currentUser;

  MessageStream({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection(firestoreDocumentId).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages!) {
            Map<String, dynamic> messageData =
                message.data() as Map<String, dynamic>;
            final messageText = messageData['text'];
            final sender = messageData['sender'];

            messageWidgets.add(MessageBubble(
              text: messageText,
              sender: sender,
              isMe: currentUser == sender,
            ));
            //messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: ListView(
                
                children: [
                  ...messageWidgets,
                ],
              ),
            ),
          );
        });
  }
}
