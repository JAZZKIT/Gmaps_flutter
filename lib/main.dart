// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gmaps_practice/DAO/developerDAO.dart';
import 'package:gmaps_practice/database/database.dart';
import 'package:gmaps_practice/screens/home_screen.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gmaps_practice/screens/map_screen.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDataBase.databaseBuilder('gmapsDenny_database.db').build();
  final dao = database.developerDAO;
  // await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // /// Create an Android Notification Channel.
  // ///
  // /// We use this channel in the `AndroidManifest.xml` file to override the
  // /// default FCM channel to enable heads up notifications.
  // await flutterLocalNotificationsPlugin!
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  final DeveloperDAO dao;
  MyApp({required this.dao});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen(dao: dao),
    );
  }
}
