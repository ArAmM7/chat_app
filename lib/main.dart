import 'package:chat_app/Views/Auth/auth_view.dart';
import 'package:chat_app/Views/Chat/chat_view.dart';
import 'package:chat_app/Views/splash_screen.dart';
import 'package:chat_app/stores/firebase_init.dart';
import 'package:chat_app/utils/register_singletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RegisterSingletons.init();
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
      home: Observer(
        builder: (BuildContext context) => !GetIt.I<FirebaseInit>().isLoaded
            ?  SplashScreen()
            : GetIt.I<FirebaseInit>().isLoggedIn
                ?  ChatScreen()
                : AuthScreen(),
      ),
    );
  }
}
