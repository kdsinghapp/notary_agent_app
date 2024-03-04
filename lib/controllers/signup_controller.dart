import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

import '../import.dart';
import '../screens/auth/upload_signup_profile.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _loading = false;
  bool get loading => _loading;

  bool _checkBox = false;
  bool get checkBox => _checkBox;
  set checkBox(bool val) {
    _checkBox = val;
    refresh();
  }

  String? _firstName;
  set firstName(String val) {
    _firstName = val;
    refresh();
  }

  String? _lastName;
  set lastName(String val) {
    _lastName = val;
    refresh();
  }

  String? _email;
  set email(String val) {
    _email = val;
    refresh();
  }

  String? _mobile;
  set mobile(String val) {
    _mobile = val;
    refresh();
  }

  String? _password;
  set password(String val) {
    _password = val;
    refresh();
  }

  String? _cnfPassword;
  set cnfPassword(String val) {
    _cnfPassword = val;
    refresh();
  }

  Future<void> signup(BuildContext context) async {
    if (formKey.currentState?.validate() != true) {
      return;
    } else {
      formKey.currentState!.save();
      _loading = true;
      refresh();
      if (_password!.toString() == _cnfPassword!.toString()) {
        formKey.currentState!.save();
        _loading = true;
        refresh();
        try {
          String deviceToken =
              await FirebaseMessaging.instance.getToken() ?? '';
          var res = await api().post(
            'signup_user',
            data: {
              "email": _email,
              "password": _password,
              /* "first_name": _firstName,
          "last_name": _lastName,
          "phone": _mobile,
          "country": "Not Provided",
          "state": "Not Provided",
          "city": "Not Provided",
          "type": "AGENT",
          "mobile": _mobile,
          "address": "Not Provided",
          "online_status": "OFFLINE",  */
              "register_id": deviceToken,
              "device_type": 'ANDROID'
            },
          );
          _loading = false;
          print('SignUp responce:- ${res.data.toString()}');
          if (res.data['status'] == "true") {
            // updateUserDetails()
            refresh();
            // context.pop();
            // context.replace(() => const HomeDrawer());
            //signUpLaunchUrl();
            context.replace(() => const UploadSignUpProfile());
          } else {
            showError(context, "can't signup");
          }
        } catch (e) {
          _loading = false;
          refresh();
          showError(context, e);
        }
      } else {
        showError(context, 'Password and conform password are not matched');
      }
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
