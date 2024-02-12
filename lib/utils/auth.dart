import 'dart:convert';
import 'dart:developer';

import 'package:notary_agent_app/models/UserProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LoginModel.dart';

void updateUserDetails(details) async {
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  // user_data=details;
  String user = jsonEncode(details);
  shared_User.setString('user_details', user);
}

Future getUserDetails() async {
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String userMap = await shared_User.getString('user_details')!;
  String userS = (userMap == null) ? '' : userMap;
  Map<String, dynamic> user = jsonDecode(userS) as Map<String, dynamic>;
  return user; //.toString();// }
}
Future<LoginModel> getDriverDetails() async {
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String userMap =shared_User.getString('user_details')!;
  String userS = (userMap == null) ? '' : userMap;
  Map<String, dynamic> user = jsonDecode(userS) as Map<String, dynamic>;
  return LoginModel.fromJson(user); //.toString();// }
}


Future getUserName() async {
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String userMap = await shared_User.getString('user_details')!;
  String userS = (userMap == null) ? '' : userMap;
  Map<String, dynamic> user = jsonDecode(userS) as Map<String, dynamic>;
  return user['first_name'].toString(); //.toString();
  // }
}

Future getCurrentUserId() async {
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  String? userMap = await shared_User.getString('user_details');
  String userS = (userMap == null) ? '' : userMap;
  Map<String, dynamic> user = jsonDecode(userS) as Map<String, dynamic>;
  // log('this is '+user['user_id'])
  return user['data']['id'].toString(); //.toString();
  // }
}

void updateUserId(id) async {
  // await FlutterSession().set("user_id", id);
}

Future isUserLoggedIn() async {
  final sharedUser = await SharedPreferences.getInstance();

  String? user = await sharedUser.getString('user_details');
  log(user.toString());

  if (user == null) {
    return false;
  } else {
    return true;
    log('user is already logged in ' + user);
  }
  // await FlutterSession().get("user_details", details);
}

Future logout() async {
  print('logout-----');
  // FirebasePushNotifications.update_device_token(false);
  new Future.delayed(const Duration(milliseconds: 5), () async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    await shared_User.clear();
    return true;
  });
}
