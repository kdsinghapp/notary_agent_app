import '../import.dart';

class CardController extends GetxController {
  String? _name;
  String? _cardNumber;
  String? _month;
  String? _year;
  String? _securityCode;
  bool _loading = false;
  bool get loading => _loading;

  set cardNumber(String val) => _cardNumber = val;
  set month(String val) => _month = val;
  set name(String val) => _name = val;
  set year(String val) => _year = val;
  set securityCode(String val) => _securityCode = val;
  Future<void> addcard(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => AddCard());
  }
}
