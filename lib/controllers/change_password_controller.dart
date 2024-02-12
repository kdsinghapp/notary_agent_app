import 'package:notary_agent_app/import.dart';

class ChangePasswordController extends GetxController {
  String? _password;
  String? _newpassword;
  String? _conpassword;
  set password(String val) => _password = val;
  set newpassword(String val) => _newpassword = val;
  set conpassword(String val) => _conpassword = val;
  Future<void> changepass(BuildContext context) async {
    context.pop();
  }
}
