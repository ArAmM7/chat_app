import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.isMe, this.username, this.userImage, {Key? key})
      : super(key: key);

  final String message;
  final bool isMe;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.surface,
            isMe ? BlendMode.srcOut : BlendMode.dstATop,
          ),
          child: Container(
            width: double.infinity,
            alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
            color: Colors.transparent,
            child: _Bubble(isMe: isMe, userImage: userImage, message: message, username: username),
          ),
        ),
        _Bubble(
            isMe: isMe, userImage: userImage, message: message, username: username, isShow: true),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    Key? key,
    required this.isMe,
    required this.userImage,
    required this.message,
    required this.username,
    this.isShow = false,
  }) : super(key: key);

  final bool isMe;
  final String userImage;
  final String message;
  final String username;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        const SizedBox(width: 4),
        if (!isMe)
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
                foregroundImage: isShow ? Image.network(userImage).image : null,
                backgroundColor: Theme.of(context).colorScheme.background.withAlpha(64)),
          ),
        Container(
          decoration: BoxDecoration(
            color: isMe && isShow ? Colors.transparent : Theme.of(context).colorScheme.background,
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
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isShow
                      ? isMe
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.onSurface
                      : null,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isShow
                      ? isMe
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.onSurface
                      : null,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
        if (isMe)
          Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              foregroundImage: isShow ? Image.network(userImage).image : null,
              backgroundColor: Theme.of(context).colorScheme.background.withAlpha(64),
            ),
          ),
        const SizedBox(width: 4),
      ],
    );
  }
}
