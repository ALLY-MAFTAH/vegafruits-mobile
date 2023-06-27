// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vegafruits/layout.dart';
import 'providers/data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => DataProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DataProvider dataProvider = DataProvider();

  @override
  void initState() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            macOS: initializationSettingsMacOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    FirebaseMessaging.instance.subscribeToTopic('all');
    FirebaseMessaging.instance.getToken().then((token) => print(token));

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );
    FlutterLocalNotificationsPlugin flutterLocNotiPlug =
        FlutterLocalNotificationsPlugin();

    flutterLocNotiPlug
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'foreground_notification_channel_id',
                'Foreground Notifications',
                channelDescription: 'Foreground Notifications Description',
                channelShowBadge: true,
                importance: Importance.max,
                priority: Priority.high,
                onlyAlertOnce: true,
                enableVibration: true,
                enableLights: true,
              ),
            ));
      }
    });
    dataProvider.getAllOrders();
    super.initState();
  }

  void selectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      // OpenFile.open(obj['filePath']);
    } else {
      print("Eraaaaaaaaa");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: dataProvider,
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Layout()),
    );
  }
}

// import 'package:flutter/material.dart';

// class CustomSideDrawer extends StatefulWidget {
//   @override
//   _CustomSideDrawerState createState() => _CustomSideDrawerState();
// }

// class _CustomSideDrawerState extends State<CustomSideDrawer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool _isDrawerOpen = false;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );

//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _toggleDrawer() {
//     setState(() {
//       _isDrawerOpen = !_isDrawerOpen;
//       if (_isDrawerOpen) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Side Drawer'),
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: _toggleDrawer,
//         ),
//       ),
//       body: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               if (_isDrawerOpen) {
//                 _toggleDrawer();
//               }
//             },
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               transform: Matrix4.translationValues(
//                 _isDrawerOpen ? MediaQuery.of(context).size.width * 0.6 : 0,
//                 0,
//                  0,
//               ),
//               child: Scaffold(
//                 body: Center(
//                   child: Text('Main Screen Content'),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             bottom: 0,
//             left: _isDrawerOpen ? 0 : -MediaQuery.of(context).size.width * 0.6,
//             width: MediaQuery.of(context).size.width * 0.6,
//             child: SlideTransition(
//               position: Tween<Offset>(
//                 begin: Offset(-1, 0),
//                 end: Offset(0, 0),
//               ).animate(_animation),
//               child: GestureDetector(
//                 onTap: () {
//                   if (_isDrawerOpen) {
//                     _toggleDrawer();
//                   }
//                 },
//                 child: Container(
//                   color: Colors.white,
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: [
//                       DrawerHeader(
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                         ),
//                         child: Text(
//                           'Drawer Header',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.home),
//                         title: Text('Home'),
//                         onTap: () {
//                           // Handle drawer item tap
//                           _toggleDrawer();
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.settings),
//                         title: Text('Settings'),
//                         onTap: () {
//                           // Handle drawer item tap
//                           _toggleDrawer();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: CustomSideDrawer(),
//   ));
// }
