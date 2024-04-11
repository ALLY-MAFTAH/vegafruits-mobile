// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vegafruits/layout.dart';
import 'package:vegafruits/providers/customer_provider.dart';
import 'package:vegafruits/providers/good_provider.dart';
import 'package:vegafruits/providers/order_provider.dart';
import 'package:vegafruits/providers/sale_provider.dart';
import 'package:vegafruits/providers/stock_provider.dart';
import 'providers/data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DataProvider dataProvider = DataProvider();
  final OrderProvider orderProvider = OrderProvider();
  final SaleProvider saleProvider = SaleProvider();
  final GoodProvider goodProvider = GoodProvider();
  final StockProvider stockProvider = StockProvider();
  final CustomerProvider customerProvider = CustomerProvider();

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
    // orderProvider.getAllOrders();
    // saleProvider.getAllSales();
    // goodProvider.getAllGoods();
    // stockProvider.getAllStocks();
    // customerProvider.getAllCustomers();
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
        ChangeNotifierProvider.value(
          value: orderProvider,
        ),
        ChangeNotifierProvider.value(
          value: goodProvider,
        ),
        ChangeNotifierProvider.value(
          value: saleProvider,
        ),
        ChangeNotifierProvider.value(
          value: stockProvider,
        ),
        ChangeNotifierProvider.value(
          value: customerProvider,
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
