import 'package:chat_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'firebase_init.g.dart';

class FirebaseInit = _FirebaseInit with _$FirebaseInit;

abstract class _FirebaseInit with Store {
  _FirebaseInit() {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then(
      (_) {
        _initNotifications().then(
          (_) => FirebaseAuth.instance.userChanges().listen(
            (event) {
              if (event == null) {
                isLoggedIn = false;
                isLoaded = true;
              } else {
                isLoggedIn = true;
                isLoaded = true;
              }
            },
          ),
        );
      },
    );
  }

  @observable
  bool isLoaded = false;

  @observable
  bool isLoggedIn = false;

  @action
  Future<void> _initNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await FirebaseFirestore.instance.enableNetwork();
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    await messaging.setAutoInitEnabled(true);

    await messaging.setForegroundNotificationPresentationOptions(
        sound: true, badge: true, alert: true);
    await messaging.getInitialMessage();

    FirebaseMessaging.onMessage.listen(
      (event) {
        if (kDebugMode) {
          print('Got a message whilst in the foreground!');
          print('Message: ${event.data}');
        }

        final notification = event.notification;
        if (notification != null) {
          if (kDebugMode) {
            print(
                'Message also contained a notification: ${notification.title} : ${notification.body}');
          }
        }
      },
    );

    await messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    await messaging.subscribeToTopic('chat').then((value) {
      if (kDebugMode) {
        print('Subscribed to topic chat!!!');
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    if (kDebugMode) {
      print('Finished setting up crashalytics!!!');
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final notification = message.notification;
    if (notification != null) {
      print('Handling a background notification: ${notification.title} : ${notification.body}');
    }
    print('Handling a background notification: ${message.data}');
  }
}
