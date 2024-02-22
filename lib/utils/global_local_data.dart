
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GlobalLocalData extends GetxController{
    static String requestId='';
      RxBool paymentComplete=false.obs;

    static String getRequestId(){
      return requestId;
    }

    static void setRequestId(String id){
        requestId=id;
    }

     void changePaymentStatus(){
        paymentComplete.value=true;
        update();
       //refresh();
    }
}