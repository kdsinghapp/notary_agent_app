import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notary_agent_app/apis/firebasesetup.dart';
import 'package:url_launcher/url_launcher.dart';

import '../import.dart';
import '../screens/NewScreens/NewDashboard.dart';
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
      if (Platform.isAndroid){
          device_type='ANDROID';
      }
      else if(Platform.isIOS){
        device_type='IOS';
      }
      String deviceToken=await FirebaseMessaging.instance.getToken()??'';
     var res = await api().post('login',
          data: {"email": _email, "password": _password, "type": "AGENT","reg"
              "ister_id":deviceToken,"device_type":device_type});
      _loading = false;
      print("my device id:--->" +deviceToken);
       print("res from login data1 ------------------${res.data}");
       print("status ------------------${res.data['status']}");

     if(res.data['status']=="true"){
       updateUserDetails(res.data);
       var userrr= await getUserDetails();
       print("yuuuuu-------------$userrr");
       refresh();
       context.pop();
       context.replace(() => NewDashboardScreen(isRequest: false,));
       //context.replace(() => const HomeDrawer());

     }
     else{
       print("can't login");
       showError(context, "can't login");
     }

    } catch (e) {
      _loading = false;
      refresh();
      showError(context, e);
    }
  }

  Future<void> signUpLaunchUrl() async {
    final Uri url = Uri.parse('https://dcmdmobilenotary.com/laravel/register_agent_new');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

// class NewController extends GetxContr+oller {}
