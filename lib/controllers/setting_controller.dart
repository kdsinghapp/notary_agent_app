import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/screens/agent/terms.dart';

import '../screens/agent/privacy.dart';

class SettingController extends GetxController {
  Future<void> terms(BuildContext context) async {
    context.navigate(() => const TermsScreen());
  }
  Future<void> privacy(BuildContext context) async {
    context.navigate(() => const PrivacyScreen());
  }
  Future<void> contactus(BuildContext context) async {
    context.navigate(() => const ContactUs());
  }
}
