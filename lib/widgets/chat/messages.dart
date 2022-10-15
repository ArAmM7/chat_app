import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
            //padding: const EdgeInsets.symmetric(horizontal: 4),
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) => MessageBubble(
              chatDocs[index]['text'],
              chatDocs[index]['userId'] == FirebaseAuth.instance.currentUser!.uid,
              chatDocs[index]['username'],
              chatDocs[index]['userImage'],
              //key: ValueKey(chatDocs[index].id),
            ),
          );
        }
      },
    );
  }
}
