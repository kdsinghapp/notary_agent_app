import '../import.dart';

class AddRateController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  List keys = [
    "DRESS COAT",
    "ON TIME",
    "KNOLIGABLE",
    "PROFESSIONALISM",
    "OVER ALL"
  ];
  bool _loading = false;
  bool _checkBox = false;
  bool get checkBox => _checkBox;
  set checkBox(bool val) {
    _checkBox = val;
    refresh();
  }

  Future<void> Booknow(BuildContext context) async {
    refresh();
    // context.pop();
    context.navigate(() => const CheckOutScreeen());
  }

  Future<void> getState(BuildContext context) async {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    formKey.currentState!.save();
    _loading = true;
    refresh();
    try {
      api().get('login');
      _loading = false;
      refresh();
      context.pop();
      context.replace(() => const HomeDrawer());
    } catch (e) {
      _loading = false;
      refresh();
      showError(context, e);
    }
  }

  Future<void> submitPayment(BuildContext context) async {
    refresh();
    displayDialog(
        context, "NotaryClient", "OK", "Thanks for your Business", false, () {
      context.pop();
    });
  }
}
