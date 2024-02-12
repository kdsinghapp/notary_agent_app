import 'package:notary_agent_app/screens/agent/MySignings.dart';

import '../import.dart';

import '../screens/agent/BookingStatus.dart';
import '../screens/agent/BookingStatus.dart';
import '../screens/agent/MyWallet.dart';
import '../screens/home/currentShipping.dart';
import '../utils/auth.dart';

class HomeDrawerController extends GetxController {

  final List<Tuple2<Tuple2<String, Widget>, Tuple2<String, Widget>>>
      drawerItems = [
    const Tuple2(Tuple2("Home", Icon(Icons.home)), Tuple2("Home", Home(isPopup: true,),)),
  ];
   
  int _selectedPage = 0;
  int get selectedPage => _selectedPage;
  set selectedPage(int page) {
    if (page < drawerItems.length) _selectedPage = page;
    refresh();
  }

  String get title => drawerItems[_selectedPage].item2.item1;
  Widget get body => drawerItems[_selectedPage].item2.item2;

  List<Tuple2<String, Widget>> get drawerData =>
      drawerItems.map((e) => e.item1).toList();

  Future<void> HomeScreen(BuildContext context) async {
    refresh();
    context.pop();
  }

  Future<void> ChangePasswordScreen(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => ChangePassword());
  }

  Future<void> MyWallet(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() =>  MyWalletScreen());
  }

  Future<void> Booking(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => const BookingStatus());
  }

  Future<void> MySetting(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => const SettingScreen());
  }

  Future<void> Signing(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => const MySignings());
  }

  Future<void> Emergency(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => const ContactUs());
  }

  Future<void> Shipping(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => const CurrentShipping());
  }

  Future<void> AboutUs(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => const AboutUsScreen());
  }

  Future<void> Setting(BuildContext context) async {
    refresh();
    context.pop();
    context.navigate(() => const SettingScreen());
  }

  Future<void> LogOut(BuildContext context) async {
    logout();
    refresh();
    context.pop();
    context.navigate(() => const Login());
  }
}
