import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notary_agent_app/screens/NewScreens/NewDashboard.dart';

import '../../apis/GlobalVariables.dart';
import '../../apis/firebasesetup.dart';
import '../../import.dart';
import '../../services/popShowAccordingNotification.dart';
import '../../utils/auth.dart';
import '../../utils/global_local_data.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  goto() async {
    Timer(const Duration(seconds: 1), () async {
      if (await isUserLoggedIn()) {
        print("true");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NewDashboardScreen(isRequest: false,)));
      } else {
        print("false");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
      }
    });
  }
  void callingFirebasePushNotification() async{
    if (Platform.isAndroid) {
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
            if(payload.payload!=null){
              try{
                // Map data = jsonDecode(payload.toString());
                var data= jsonDecode(payload.payload!);
                log('this is notification when press ---${payload.payload}  ');
                log('this is notification when press ---${data}  ');
                log('this is notification when press ---${data['type']}  ');
                if(data['type']=='REQUEST'){
                  log('this is notification aa aa ---  ');
                  GlobalLocalData.setRequestId(data['request_id'].toString());
                  Navigator.push(MyGlobalKeys.navigatorKey.currentContext!,
                      MaterialPageRoute(builder: (context)=>NewDashboardScreen(isRequest: true))) ;
                }

                if(data['type']=='CANCEL_BY_USER'){
                  popShowAccordingNotification(context, 'CANCEL_BY_USER');
                }
                if(data['type']=='PAYMENT_DONE'){
                  popShowAccordingNotification(context, 'PAYMENT_DONE');
                }


              }catch(e){
                print('Error when press:- $e');
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

  }

  @override
  void initState() {
    // TODO: implement initState
    callingFirebasePushNotification();
    goto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: CC.primary),
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
