import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/firebase_options.dart';
import 'package:flutter_lab2_222006/screens/HomeScreen.dart';

import 'services/notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message received: ${message.notification?.title}");
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();


  final token = await messaging.getToken();
  print("FCM Token: $token");
  await NotificationService.initialize();

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notif = message.notification;

      if (notif != null) {
        NotificationService.showNotification(
          title: notif.title ?? "New Notification",
          body: notif.body ?? "",
        );
      }
    });
    //Tuka menuvam vreme
    NotificationService.scheduleDailyRecipeNotification(
    hour: DateTime.now().hour,
  minute: DateTime.now().minute + 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Recipes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TheMeal(),
    );
  }
}
