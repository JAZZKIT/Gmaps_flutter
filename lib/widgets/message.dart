// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class MessagingWidget extends StatefulWidget {
//   const MessagingWidget();

//   @override
//   _MessagingWidgetState createState() => _MessagingWidgetState();
// }

// class _MessagingWidgetState extends State<MessagingWidget> {
//   //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   @override
//   void initState() {
//     super.initState();
//     var initialzationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//         InitializationSettings(android: initialzationSettingsAndroid);

//     flutterLocalNotificationsPlugin!.initialize(initializationSettings);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin!.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channel.description,
//                 // TODO add a proper drawable resource to android, for now using
//                 //      one that already exists in example app.
//                 icon: 'launch_background',
//               ),
//             ));
//       }
//     });
//     getToken();
//   }

//   getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     print(token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
