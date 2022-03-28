import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';

class MessageBubble extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MessageBubble(
      {required this.text, required this.sender, required this.isMe});

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
                color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          Material(
            borderRadius:
                isMe ? kRightBubbleBorderRadius : kLeftBubbleBorderRadius,
            elevation: 10,
            shadowColor: Colors.red,
            color: isMe ? Colors.white : Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
