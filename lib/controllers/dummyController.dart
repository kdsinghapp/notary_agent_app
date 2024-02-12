import 'package:get/get.dart';
import 'package:notary_agent_app/models/bookingChangeStatusModel.dart';

import '../apis/CustomSnackBar.dart';
import '../import.dart';
import '../utils/auth.dart';

class DummyController extends GetxController{
  Future<void> acceptRejectRequest(BuildContext context,String status,String requestId) async {
    try {
      final res = await api().post('driver_accept_and_Cancel_request',
          data: {"status": status, "request_id": requestId, "driver_id":await getCurrentUserId()});

      // final resdata = UpdateOnlineStatus.fromJson(res as Map<String, dynamic>);
      // print("resdata is....${resdata.data}");


      print("res from login data2 ------------------${res.data}");
      print("status ------------------${res.data['status']}");

      final data = BookingChangeStatusModel.fromJson(res.data);
      if (data.status == "true") {
        if(status =="Accept"){
          showSnackbar(context, "You have Accepted the booking request");
        }
        else{
          showSnackbar(context, "You have Cancelled the booking request");
        }
      } else {
        showSnackbar(context,"${data.message}");
      }
    } catch (e) {
      refresh();
      showError(context, e);
    }
  }

  @override
  void onInit() {
    // getCurrentLocation();
    // TODO: implement onInit
    super.onInit();
  }
}