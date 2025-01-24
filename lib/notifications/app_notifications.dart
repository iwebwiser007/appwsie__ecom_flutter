// import 'package:cleaner_app/constants/app_constant.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// FirebaseMessaging messaging = FirebaseMessaging.instance;
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp();
//   // await showFlutterNotification(message);
//   // // If you're going to use other Firebase services in the background, such as Firestore,
//   // // make sure you call `initializeApp` before using other Firebase services.
//   // if (message.notification != null) {
//   //   NotificationModel notificationModel = NotificationModel(
//   //     title: message.notification?.title,
//   //     notificationContent: message.notification?.body,
//   //     receiveDate: Timestamp.now(),
//   //     linkedItemId: message.data["id"],
//   //     imageUrl: message.data["imageUrl"],
//   //     userId: AppConst.getAccessToken(),
//   //     isRead: false,
//   //     id: generateUid(),
//   //   );
//   //   await NotificationModel.addNotification(notificationModel);
//   // }
//   if (kDebugMode) {
//     print('Handling a background message ${message.notification}');
//   }
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late final AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.',
//     importance: Importance.max,
//   );

//   final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
//     requestSoundPermission: false,
//     requestBadgePermission: false,
//     requestAlertPermission: false,
//     // onDidReceiveLocalNotification: (id, title, body, payload) async {},
//   );

//   final InitializationSettings initializationSettings =
//       InitializationSettings(iOS: initializationSettingsDarwin, macOS: initializationSettingsDarwin, android: const AndroidInitializationSettings("@mipmap/ic_launcher"));
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse: (NotificationResponse details) async {},
//   );
//   await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// Future<void> showFlutterNotification(RemoteMessage message) async {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id.toString(),
//             channel.name.toString(),
//             channelDescription: channel.description,
//             importance: Importance.max,
//             priority: Priority.max,
//             icon: '@mipmap/ic_launcher',
//             ticker: 'ticker',
//           ),
//           iOS: const DarwinNotificationDetails()),
//     );
//   }
// }

// // /// Renders the example application,

// Future<void> setAllNotification() async {
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     if (message.notification != null) {
//       await showFlutterNotification(message);
//       // final response = await RequestUtils().getRequest(url: ServiceUrl.profileUrl);
//       // AppConst.getWidgetRef()?.read(userDataProvider.notifier).storeUserData(response);
//       // AppConst.getWidgetRef()?.read(userTypeProvider.notifier).update((state) => response["data"]["type"]);
//     }
//     if (kDebugMode) {
//       print('handling a foreground app $message');
//     }
//   });
// }

// Future<NotificationSettings> requestPermissions() async {
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   if (kDebugMode) {
//     print('User granted permission: ${settings.authorizationStatus}');
//   }
//   return settings;
// }

// Future<String?> getToken() async {
//   try {
//     final setting = await requestPermissions();
//     if (setting.authorizationStatus == AuthorizationStatus.authorized) {
//       String? token = await messaging.getToken();
//       if (kDebugMode) {
//         print('FCM token: $token');
//       }
//       if (token != null) {
//         print(token);
//         AppConst.setFcmToken(token);
//       }
//       return token;
//     }
//     return null;
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//   }
//   return null;
// }

// Future<void> setupInteractedMessage() async {
//   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//   if (initialMessage != null) {
//     // ignore: use_build_context_synchronously
//   }
//   FirebaseMessaging.onMessageOpenedApp.listen((event) async {
//     // final response = await RequestUtils().getRequest(url: ServiceUrl.profileUrl);
//     // AppConst.getWidgetRef()?.read(userDataProvider.notifier).storeUserData(response);
//     // AppConst.getWidgetRef()?.read(userTypeProvider.notifier).update((state) => response["data"]["type"]);
//   });
// }

// // void _handleMessage(RemoteMessage message) {
// //   if (message.data['type'] == 'chat') {
// //   } else if (message.data["type"] == "workItem") {}
// // }
