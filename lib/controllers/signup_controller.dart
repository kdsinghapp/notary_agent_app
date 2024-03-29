import 'package:notary_agent_app/apis/firebasesetup.dart';

import '../import.dart';

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

  Future<void> signup(BuildContext context) async {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    formKey.currentState!.save();
    _loading = true;
    refresh();
    try {
      String device_type = '';
      if (Platform.isAndroid){
        device_type='ANDROID';
      }
      else if(Platform.isIOS){
        device_type='IOS';
      }
      var res = await api().post(
        'signup_user',
        data: {
          "first_name": _firstName,
          "last_name": _lastName,
          "email": _email,
          "password": _password,
          "country": "Not Provided",
          "state": "Not Provided",
          "city": "Not Provided",
          "mobile": _mobile,
          "address": "Not Provided",
          "type": "AGENT",
          "register_id":devicetoken  ,
          "device_type":device_type
        },
      );
      _loading = false;

      if(res.data['status']=="true"){
       // updateUserDetails()
        refresh();
        context.pop();
        context.replace(() => const HomeDrawer());
      }
      else{
        showError(context, "can't signup");
      }

    } catch (e) {
      _loading = false;
      refresh();
      showError(context, e);
    }
  }
}
