import '../import.dart';

class NotaryFormController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
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
}
