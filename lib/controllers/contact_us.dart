import 'package:notary_agent_app/import.dart';

class ContactUsController extends GetxController {
  String? _name;
  String? _email;
  String? _message;
  set name(String val) => _name = val;
  set email(String val) => _email = val;
  set msg(String val) => _message = val;
  Future<void> submit(BuildContext context) async {
    context.pop();
  }
}
