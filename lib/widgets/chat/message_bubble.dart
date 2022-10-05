import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String userImage;

  const MessageBubble(this.message, this.isMe, this.username, this.userImage, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
              foregroundImage: Image.network(userImage).image,
              backgroundColor: Theme.of(context).colorScheme.background.withAlpha(64)),
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.background.withAlpha(64),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: isMe ? const Radius.circular(20) : const Radius.circular(0),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(20),
            ),
          ),
          width: min(240, max(message.trim().length * 16, username.trim().length * 16)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.onBackground)),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onBackground,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
        if (isMe)
          CircleAvatar(
              foregroundImage: Image.network(userImage).image,
              backgroundColor: Theme.of(context).colorScheme.background.withAlpha(64)),
      ],
    );
  }
}
