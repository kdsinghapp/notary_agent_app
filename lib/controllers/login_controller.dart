import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notary_agent_app/models/LoginModel.dart';
import 'package:notary_agent_app/screens/auth/signup_status.dart';
import 'package:notary_agent_app/screens/auth/signup_step3.dart';
import 'package:notary_agent_app/screens/auth/upload_other_document.dart';
import 'package:notary_agent_app/screens/auth/upload_signup_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../import.dart';
import '../screens/NewScreens/NewDashboard.dart';
import '../screens/auth/signup_step4.dart';
import '../screens/auth/signup_step5.dart';
import '../utils/auth.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _loading = false;
  String? _email;
  String? _password;

  bool get loading => _loading;
  set email(String val) => _email = val;
  set password(String val) => _password = val;

  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    formKey.currentState!.save();
    _loading = true;
    refresh();
    try {
      String device_type = '';
      if (Platform.isAndroid) {
        device_type = 'ANDROID';
      } else if (Platform.isIOS) {
        device_type = 'IOS';
      }
      String deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
      var res = await api().post('login', data: {
        "email": _email,
        "password": _password,
        "type": "AGENT",
        "reg"
            "ister_id": deviceToken,
        "device_type": device_type
      });
      _loading = false;
      print("my device id:--->" + deviceToken);
      print("res from login data1 ------------------${res.data}");
      print("status ------------------${res.data['status']}");
      LoginModel model = LoginModel.fromJson(res.data);

      if (res.data['status'] == "true") {
        updateUserDetails(res.data);
        if (model.data!.agentStep1 == 0) {
          context.replace(() => UploadSignUpProfile());
        } else if (model.data!.agentStep2 == 0) {
          context.replace(() => UploadOtherDocument());
        } else if (model.data!.agentStep3 == 0) {
          context.replace(() => SignUpStep3Page());
        } else if (model.data!.agentStep4 == 0) {
          context.replace(() => SignUpStep4Page());
        } else if (model.data!.agentStep5 == 0) {
          context.replace(() => SignUpStep5Page());
        } else {
          if (model.data!.agentStep1Admin == 1 &&
              model.data!.agentStep2Admin == 1 &&
              model.data!.agentStep3Admin == 1 &&
              model.data!.agentStep4Admin == 1 &&
              model.data!.agentStep5Admin == 1) {
            loginUser();
            context.pop();
            context.replace(() => NewDashboardScreen(
                  isRequest: false,
                ));
          } else {
            context.replace(() => SignUpStatus());
          }
        }

        // var userrr = await getUserDetails();
        // print("yuuuuu-------------$userrr");

        refresh();
      } else {
        print("can't login");
        showError(context, "can't login");
      }
    } catch (e) {
      _loading = false;
      refresh();
      print("Error:-" + e.toString());
      showError(context, e);
    }
  }

  Future<void> signUpLaunchUrl() async {
    final Uri url =
        Uri.parse('https://dcmdmobilenotary.com/laravel/register_agent_new');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

// class NewController extends GetxContr+oller {}
