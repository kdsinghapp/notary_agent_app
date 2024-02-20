import 'package:http/http.dart' as http;
import 'dart:convert';

void sendPushNotification(String receiverDeviceId,String requestId,String driverId,String userId,) async {
  const String serverKey = 'AAAAeWp9Ma0:APA91bGL_r0u_1vU7DfHigRa1goVsP0E0jcwyCNfPRmZ1oUxliZNPFBQ-QArXWU8DSB3bH4zlEdtwiKgb9juTxTkA0ytwlUCvc-RK7UZlUkAszLzOQK5xT6WxQ_NxfRwas9H08HA6gB2';
  const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  final message = {
    'notification': {
      'title': 'New Message',
      'body': 'You have received a new message',
    },
    'data': {
      'request_id': requestId,
      'type': 'CHAT',
      'driverId':driverId,
      'userId':userId
    },
    'to': receiverDeviceId,
  };

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final response = await http.post(
    Uri.parse(fcmUrl),
    headers: headers,
    body: jsonEncode(message),
  );

  if (response.statusCode == 200) {
    print('Push notification sent successfully');
  } else {
    print('Failed to send push notification');
  }
}