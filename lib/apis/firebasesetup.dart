import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notary_agent_app/apis/GlobalVariables.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/screens/NewScreens/NewDashboard.dart';
import 'package:notary_agent_app/screens/agent/BookingStatus.dart';
import 'package:notary_agent_app/utils/global_local_data.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../LifecycleEventHandler.dart';
import '../screens/NewScreens/NewChatingScreen.dart';
import '../services/popShowAccordingNotification.dart';
import '../utils/auth.dart';

var loginid;

String devicetoken='';
// {receiver: 51, sender: 55, screen: chat_page}
FirebaseMessaging messaging = FirebaseMessaging.instance;

// const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel',  'High Importance Notifications', importance: Importance.high, playSound: true);
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',  importance:
Importance.max, playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
InitializationSettings initializationSettings = InitializationSettings(

  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  iOS: DarwinInitializationSettings(),
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('A bg message just showed up -=-=-=-=1${message.notification?.title}');
  print('A bg message just showed up -=-=-=-=2${message.notification?.body}');
  print('A bg message just showed up -=-=-=-=3${message.notification?.body}');
  print('A bg message just showed up -=-=-=-=4${message.data['type']}');
  
if(message.data['type'].toString()=='REQUEST'){
  print("dddd--------------${message.data['type']}");
  Navigator.push(MyGlobalKeys.navigatorKey.currentContext!, MaterialPageRoute
    (builder: (context)=>NewDashboardScreen(isRequest: true))) ;
}
}


class FirebasePushNotifications{




  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  // );
  ///step 1: Add this to main

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//   onSelectNotification: (payload)async{
//   print('the notification is selected $payload');
//   // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
//   if(payload!=null){
//   try{
//   Map data = jsonDecode(payload);
//   if(data['screen']=='booking'){
//   Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingById + '${data['booking_id']}');
//   push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
//   }
//   }catch(e){
//   print('Error in catch block 332 $e');
//   }
//
//   }
// }
// await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  //
  // );
  // await FirebasePushNotifications.firebaseSetup();
  /// step 2:
  ///Create certificate Key from here
  /// https://console.firebase.google.com/project/cycle-up-338208/settings/cloudmessaging

  /// step 3 :
  /// get permission
  /// step 4 :
  /// get token and then store it to database, so that we can send notification to that specific
  /// android token.

  static const String webPushCertificateKey = 'BPE6NfMirgOcbGrnJJ-NvlXwMpRnWm_Df0UNwLSxFXshKgAUNF-HjNmbgye_knKsbZxmTEOQz6w10Mm9TVcibO4';
  /// this token is used to send notification // use the returned token to send messages to users from your custom server
  static String? token;



  static Future<NotificationSettings> getPermission()async{
    NotificationSettings settings = await messaging.requestPermission(

      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,

    );
    print('User granted permission: ${settings.authorizationStatus}');
    return settings;
  }


  static Future<String?> getToken()async{
    token = await messaging.getToken(
        vapidKey: webPushCertificateKey
    );
    return token;
  }


  static Future<void> firebaseSetup()async {
    // FirebaseMessaging.onBackgroundMessage((message)async{
    //   print)
    // })
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
      print('firebase messaging is being listened');
      try{
        RemoteNotification? notification = message.notification;
        var data = message.data;
        // log('notidata+--'+data.toString());
        AndroidNotification? android = message.notification?.android;
        log('this is notification bb bb 1--- ${message.data} ');
        // print('________2___${notification.toString()}');
        // print('_______message.datamessage.data_________${message.data}');
        if (!lifecycleEventHandler.inBackground){
          if (notification != null && android != null) {
          await flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
              payload:jsonEncode(data)
          );
          print('the payLoad is $data');
        }
          if(data['type']=='CHAT'){
            popChatNotification(MyGlobalKeys.navigatorKey.currentContext!,data['driverId'], data['userId'], data['request_id']);
          }

          if(data['type']=='PAYMENT_DONE'){
            GlobalLocalData data=GlobalLocalData();
            data.changePaymentStatus();
            popShowAccordingNotification(MyGlobalKeys.navigatorKey.currentContext!, 'PAYMENT_DONE');
          }
        }else{

          if(message.data['type']=='REQUEST'){
            log('this is notification aa aa ---  ');
            GlobalLocalData.setRequestId(message.data['request_id'].toString());
            Navigator.push(MyGlobalKeys.navigatorKey.currentContext!,
                MaterialPageRoute(builder: (context)=>NewDashboardScreen(isRequest: true))) ;
          }
          if(data['type']=='CANCEL_BY_USER'){
            popShowAccordingNotification(MyGlobalKeys.navigatorKey.currentContext!, 'CANCEL_BY_USER');
          }
          if(data['type']=='REVIEWED_BY_USERS'){
            popShowAccordingNotification(MyGlobalKeys.navigatorKey.currentContext!, 'REVIEWED_BY_USERS');
          }
          if(data['type']=='CHAT'){
            popChatNotification(MyGlobalKeys.navigatorKey.currentContext!,data['driverId'], data['userId'], data['request_id']);
          }

          if(data['type']=='PAYMENT_DONE'){
            GlobalLocalData data=GlobalLocalData();
            data.changePaymentStatus();
            popShowAccordingNotification(MyGlobalKeys.navigatorKey.currentContext!, 'PAYMENT_DONE');
          }


        }
      }catch(e){
        print('error in listening notifications $e');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      await Firebase.initializeApp();

      print('A new onMessageOpenedApp event was published!');
      print(message.data);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      String title = "";


      if(message.data['type']=='REQUEST'){
        log('this is notification aa aa ---  ');
         GlobalLocalData.setRequestId(message.data['request_id'].toString());
        Navigator.push(MyGlobalKeys.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context)=>NewDashboardScreen(isRequest: true))) ;
      }
      if(message.data['type']=='CHAT'){
        Navigator.push(MyGlobalKeys.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context)=>NewChatScreen(userId: message.data['driverId'],myId: message.data['userId'],
                requestId:message.data['request_id']))) ;
      }
    });

    FirebaseMessaging.instance.getToken().then((value)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loginid = prefs.getString("user_id");
      token=value.toString();
      devicetoken=value.toString();
      print('device token---------------------- '+value.toString());
      var tokenId=value!;
      print('device token---------------------- '+token.toString());

      if (await isUserLoggedIn()) {
        final res = await api().post('update_user_token',
            data: {"user_id": await getCurrentUserId(), "register_id": token.toString(),});
        print(res) ;
      }

      if(value!=null){

      }

      // log("token-------"+value.toString());
    });

  }



}