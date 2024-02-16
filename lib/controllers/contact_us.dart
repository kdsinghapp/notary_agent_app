import 'package:notary_agent_app/import.dart';

import '../widgets/ShowToast.dart';

class ContactUsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _loading = false;
  String? _name;
  String? _email;
  String? _message;
  bool get loading => _loading;
  set name(String val) => _name = val;
  set email(String val) => _email = val;
  set msg(String val) => _message = val;
  Future<void> submit(BuildContext context) async {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    _loading = true;
    refresh();
    try {
      var res = await api().post('contact_us',
          data: {"contact_us_name": _name,
            "contact_us_email": _email,
            "contact_us_message": _message});
      print("res----from login----$res");
      showToastMessage('Contact us successfully complete. ');
    }catch(e){
      print("Error----$e");
      showError(context, "Contact Us form failed ...");
    }
    _loading = false;
    refresh();
  }

}
