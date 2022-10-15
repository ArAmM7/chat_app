import 'package:chat_app/providers/firebase_init.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.teal,
          onPrimary: Colors.white,
          secondary: Colors.blue,
          onSecondary: Colors.white,
          background: Colors.grey.shade300,
          onBackground: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.grey.shade200,
          onSurface: Colors.black,
        ),
      ),
      home: FutureBuilder(
        future: FirebaseInit.initializeDefault,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
            return const SplashScreen();
          } else {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (snapshot.hasData) {
                  return const ChatScreen();
                } else {
                  return const AuthScreen();
                }
              },
            );
          }
        },
      ),
    );
  }
}
