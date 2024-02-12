import '../import.dart';

class PaymentController extends GetxController {
  Future<void> addBtn(BuildContext context) async {
    refresh();
    context.navigate(() => AddCard());
  }

  Future<void> continueBtn(BuildContext context) async {
    refresh();
    // context.pop();
    // displayDialog(
    //     context,
    //     "Signing started",
    //     "OK",
    //     "107, 1st Floor Sapphire House, Sapna Sangeeta Main Road, Snehagat Agrasen Square, Snehnagar, Indore, Madhya Pradesh 452001, India Date 2021-02-04 1905",
    //     true);
    // displayDialog(
    //     context, "NotaryClient", "OK", "Thanks for your Business", false);
    // context.navigate(() => AddRate());
    //context.navigate(() => TrackSigning());
  }
}
