import 'package:chat_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseInit {
  static Future<FirebaseApp> initializeDefault = _initializeDefault();

  static Future<FirebaseApp> _initializeDefault() async {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _initNotifs();
    return app;
  }

  static Future<void> _initNotifs() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await FirebaseFirestore.instance.enableNetwork();
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    await messaging.setAutoInitEnabled(true);

    await messaging.setForegroundNotificationPresentationOptions(
        sound: true, badge: true, alert: true);
    await messaging.getInitialMessage();

    FirebaseMessaging.onMessage.listen(
      (event) {
        print('Got a message whilst in the foreground!');
        print('Message: ${event.data}');

        final notification = event.notification;
        if (notification != null) {
          print(
              'Message also contained a notification: ${notification.title} : ${notification.body}');
        }
      },
    );

    await messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    await messaging.subscribeToTopic('chat').then((value) => print('Subscribed to topic chat!!!'));
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    print('Finished setting up crashalytics!!!');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final notification = message.notification;
    if (notification != null) {
      print('Handling a background notification: ${notification.title} : ${notification.body}');
    }
    print('Handling a background notification: ${message.data}');
  }
}
