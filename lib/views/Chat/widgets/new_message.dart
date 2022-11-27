import 'package:chat_app/views/Chat/stores/message_composing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class NewMessage extends StatelessWidget {
  const NewMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withAlpha(32),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              textInputAction: TextInputAction.send,
              controller: GetIt.I<MessageComposing>().controller,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (val) => GetIt.I<MessageComposing>().updateMessage(val),
            ),
          ),
          Observer(
            builder: (context) => GetIt.I<MessageComposing>().enteredMessage.isNotEmpty
                ? IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.send),
                    onPressed: GetIt.I<MessageComposing>().enteredMessage.trim().isEmpty
                        ? null
                        : () async {
                            GetIt.I<MessageComposing>().clearMessage();
                            FocusScope.of(context).unfocus();
                            final String userId = FirebaseAuth.instance.currentUser!.uid;
                            final userData = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .get();
                            FirebaseFirestore.instance.collection('chat').add(
                              {
                                'text': GetIt.I<MessageComposing>().enteredMessage,
                                'createdAt': Timestamp.now(),
                                'userId': userId,
                                'username': userData['username'],
                                'userImage': userData['image_url'],
                              },
                            );
                          },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
