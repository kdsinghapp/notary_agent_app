import 'package:notary_agent_app/import.dart';

import '../utils/auth.dart';

class ProfileController extends GetxController {

  var user;
  String? _firstName;

  String get getFirstName{
    return "new user";
  }

  set firstName(String val) {
    _firstName = val;
    refresh();
  }

  getUserData()async{
    user = await getUserDetails();
    print("user details are....${user['data']}");
  }

  @override
  void onInit() {
    getUserData();
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> Edit(BuildContext context) async {
    context.pop();
  }
}
