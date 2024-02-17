import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notary_agent_app/apis/GlobalVariables.dart';
import 'package:notary_agent_app/apis/firebasesetup.dart';
import 'package:notary_agent_app/screens/auth/splash_screen.dart';
import 'package:notary_agent_app/screens/auth/welcome.dart';
import 'package:notary_agent_app/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';

import 'LifecycleEventHandler.dart';
@pragma('vm:entry-point')
Future<void> onBackgroundMessageHandler(RemoteMessage? message) async {
  log('background message handler called.............');
}
Future<void> main() async {
  print("main __________");
  WidgetsFlutterBinding.ensureInitialized();
  lifecycleEventHandler.init();
   /*if (Platform.isAndroid) {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse : (payload)async{
          print('the notification is selected 12 ${payload.payload}');
          // print('the notification is selected 2${jsonDecode(payload.toString
          //   ())}');
          // print('the notification is selected 3'
          //     '${payload.payload}\n${payload.notificationResponseType}'
          //     '\n${payload.actionId}\n${payload.payload}');
          // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
          if(payload!=null){
            try{
              Map data = jsonDecode(payload.toString());
              if(data['screen']=='withdrawal'){
                try{
                }catch(e){
                  print('Error in catch block 342 $e');
                }
              }
              else if(data['screen']=='order'){
                // Navigator.push(
                //   MyGlobalKeys.navigatorKey.currentContext!,
                //   MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:data['order_id'].toString(),)),
                // );
              }
            }catch(e){
              print('Error in catch block 332 $e');
            }

          }
        });
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(

      alert: true,
      badge: true,
      sound: true,
    );
    await FirebasePushNotifications.firebaseSetup();
  }
  WidgetsFlutterBinding.ensureInitialized();  */
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  initState() {

    Permission.notification.request();
    super.initState();
  }
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
        title: 'Notary Agent',
        theme: ThemeData(
          primarySwatch: primarySwatch,
        ),
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
        navigatorKey: MyGlobalKeys.navigatorKey,
      );

  }
}


