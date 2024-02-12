import '../import.dart';

class CheckOutController extends GetxController {
  Future<void> checkout(BuildContext context) async {
    refresh();
    // context.pop();
    context.navigate(() => PaymentScreen());
  }
}
