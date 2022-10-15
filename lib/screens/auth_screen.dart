import 'dart:io';

import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }

  void _submitAuthForm(
      String email, String username, String password, File userImage, bool isLogin) async {
    UserCredential cred;
    try {
      setState(() => _isLoading = true);
      if (isLogin) {
        cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
        setState(() => _isLoading = false);
      } else {
        cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        final ref =
            FirebaseStorage.instance.ref().child('user_images').child('${cred.user!.uid}.jpg');
        await ref.putFile(userImage);
        final url = await ref.getDownloadURL();
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'email': email,
          'image_url': url,
        });
        setState(() => _isLoading = false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      var message = 'Authentication failed';
      if (e.message != null) {
        message = e.message!;
      }
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
      rethrow;
    }
  }
}
