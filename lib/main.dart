import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vensemart_delivery/nav_bar_page.dart';
// import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'backend/apiservices/provider/provider.dart';
import 'backend/core/injector.dart';
import 'backend/core/session_manager.dart';
import 'flutter_flow/internationalization.dart';
import 'package:permission_handler/permission_handler.dart';

import 'index.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title// description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
}

bool _requireConsent = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeCore();
  await Firebase.initializeApp();

  // _handleLocationPermission();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  // request location permission

  // await FlutterConfig.loadEnvVariables();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  OneSignal.initialize("e5db6fdd-df18-49a3-b1c7-c2c27645e144");

  // bool requiresConsent = await OneSignal.requiresUserPrivacyConsent();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.Debug.setAlertLevel(OSLogLevel.none);

  OneSignal.consentRequired(true);

  OneSignal.consentGiven(true);

  // OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //   print("Opened notification: ${result.notification.jsonRepresentation()}");
  // });

  var rp = OneSignal.Notifications.requestPermission(true);

  rp.then((val) {
    print("Permission has been granted: $val");
    if (val) {
      // OneSignal..promptForPushNotificationsWithUserResponse();

      // AndroidOnly stat only
      // OneSignal.Notifications.removeNotification(1);
      // OneSignal.Notifications.removeGroupedNotifications("group5");
      var permission = OneSignal.Notifications.permission;

      print("Permission: $permission");
      OneSignal.Notifications.addPermissionObserver((state) {
        print("Has permission " + state.toString());
      });
    }
  });

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    print(
        'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');
    event.preventDefault();
    event.notification.display();
  });

  // Handle notification opened events
  // OneSignal.Notifications.addClickListener((event) {
  //   var additionalData = event.notification.additionalData;

  //   final customData = additionalData?['custom'];

  //   if (customData != null) {
  //     Map<String, dynamic> customDataMap = jsonDecode(customData); // Parse JSON
  //     final page = customDataMap['a']?['page'];
  //     print("Page: " + page);
  //     print("Custom Data: " + customData);
  //     handleNotification(page);

  //     // Your navigation logic based on the 'page' value ...
  //   }
  // });

  // printKeyHash();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();
  }

  void setLocale(String language) =>
      setState(() => _locale = createLocale(language));
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.getProviders,
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'vensemart-delivery',
        localizationsDelegates: [
          FFLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: const [Locale('en', '')],
        theme: ThemeData(brightness: Brightness.light),
        themeMode: _themeMode,
        home: SessionManager.instance.authToken.isNotEmpty
            ? NavBarPage()
            : GetStartedWidget(),
      ),
    );
  }
}
