import 'package:connectivity/connectivity.dart';
import 'package:e_commerce/Navigation/navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  // var initializationSettingsAndroid =
  //     AndroidInitializationSettings('ic_launcher');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     (onDidReceiveLocalNotification:
  //         (int id, String title, String body, String payload) async {}));
  // var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     (onSelectNotification: (String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload' + payload);
  //   }
  // })!);

  var connection = await Connectivity().checkConnectivity();
  //bool result= await DataConnectionChecker().hasConnection;

  if (connection == ConnectivityResult.none) {
    Fluttertoast.showToast(
        msg: 'Please check your internet connection and open again',
        textColor: Colors.white,
        backgroundColor: Colors.grey);
  } else if (connection == ConnectivityResult.mobile) {
    return runApp(MaterialApp(
      home: Navigation(),
      debugShowCheckedModeBanner: false,
    ));
  } else if (connection == ConnectivityResult.wifi) {
    return runApp(MaterialApp(
      home: Navigation(),
      debugShowCheckedModeBanner: false,
    ));
  }

  // runApp(MaterialApp(
  //   home: Navigation(),
  //   debugShowCheckedModeBanner: false,
  // ));
}
