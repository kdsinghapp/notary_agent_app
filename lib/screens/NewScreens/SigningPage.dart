import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/utils/global_local_data.dart';
import 'package:notary_agent_app/widgets/ShowToast.dart';
import 'package:shimmer/shimmer.dart';
import '../../apis/CustomSnackBar.dart';
import '../../apis/interceptor.dart';
import '../../models/GetDriverChangeStatusModel.dart';
import '../../models/GetNewPendingBookingModel.dart';
import '../../utils/auth.dart';
import '../../utils/colors.dart';
import '../../utils/util_funcs.dart';
import '../../widgets/checkoutUI.dart';
import 'package:http/http.dart' as http;

import '../home/tracking_signing.dart';

class SigningPage extends StatefulWidget{
  const SigningPage({super.key});
  @override
  State<StatefulWidget> createState() =>_SigningState();

}
class _SigningState extends State<SigningPage>{
  bool showProgressbar=true;
  bool presentData=true;
  String agent_id='';
  int tabIndex=0;
   List<GetNewPendingBookingData>? getNewPendingBookingData;

  @override
  initState(){
    super.initState();
    getNewPendingBookingAll();
  }

  getNewPendingBookingAll() async {
    try {
      final res = await api().post(apiEndPoint(tabIndex),
          data: {"agent_id": await getCurrentUserId()});
      print("res from login data2 ------------------${res.data}");
      final data = GetNewPendingBookingModel.fromJson(res.data);
      if (data.status == "true") {
        getNewPendingBookingData = data.data!;
        setState(() {
          presentData=true;
          showProgressbar=false;
        });
      } else {
        setState(() {
          presentData=false;
        });
        showSnackbar(context, "${data.message}");
      }
    } catch (e) {
      setState(() {
        presentData=false;
      });
      showError(context, e);
    }
  }

  String apiEndPoint(int index){
    switch(index){
      case 0:{
        return 'get_driver_new_accept_booking';
      }
      case 1:{
        return 'get_driver_start_arrived_booking';
      }
      case 2:{
        return 'give_driver_completed_request_id';
      }
      case 3:{
        return 'get_driver_cancel_booking';
      }
    }
    return 'get_driver_new_pending_booking';
  }

  getPop(GetNewPendingBookingData model)async{
    return   showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(minutes: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.grey.withOpacity(0.6),
          title: Center(
            child: Text(
              "Signing Request",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(model.status.toString() =="Pending")
                Container(
                  padding: EdgeInsets.all(16),
                  color:Colors.grey.withOpacity(0.4),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          acceptRejectRequest(context,'Cancel_by_driver',
                              model.id.toString());
                          Navigator.pop(context);

                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "Decline",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          acceptRejectRequest(context,'Accept',
                              model.id.toString());
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "Accept",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Client",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            /*  Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.white.withOpacity(0.40)
                ),
                child: CircularCountDownTimer(
                  width: 100,
                  height: 100,
                  duration: 180,
                  strokeWidth: 12,
                  isReverse: true,
                  ringColor: CC.primary,
                  fillColor: Colors.amber,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),  */
              sbh(5),
              Container(
                height: 300,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),

                            child: Container(
                              height: 70,
                              width: 70,
                            ),
                          ),
                          sbw(10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: '${model.carTypeName}\nTotal '
                                    'Price\$'
                                    ' ${model.totalAmount} ',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ],
                          )
                        ],
                      ),
                      sbh(10),

                      SpaceRow(
                        heading: 'Weekend Charge:',
                        value: '\$${model.weekend}',
                      ),


                      SpaceRow(
                        heading: 'Date:',
                        value: model.picklaterdate ?? '',
                        ),
                      SpaceRow(
                        heading: 'Time:',
                        value: model.picklatertime?? '',
                       ),
                      SpaceRow(
                        heading: 'Witness:',
                        value: '${model.witness}',
                      ),
                      SpaceRow(
                        heading: 'Type of Signing:',
                        value: '${model.typeOfSigningName}',
                      ),
                      SpaceRow(
                        heading: 'Location Type:',
                        value: '${model.locationType}',
                      ),
                      SpaceRow(
                        heading: 'Number of Signing:',
                        value:  '${model.numberOfSigning}',
                      ),

                      SpaceRow(
                          heading: 'Signing Location :',
                          value: "${model.picuplocation}"),





                      SpaceRow(
                        heading: 'Name:',
                        value:  '${model.name}',
                      ),
                      SpaceRow(
                        heading: 'Real Estate Signing:',
                        value: '${model.realstateSigning}',
                      ),
                      SpaceRow(
                        heading: 'Email to print:',
                        value: '\$${model.emailtoprit}',
                      ),
                      SpaceRow(
                        heading: 'Scan and Email:',
                        value: "\$${model.scanandemail}",
                      ),
                      SpaceRow(
                        heading: 'Prepaid:',
                        value: '\$${model.prepaid ?? ''}',
                      ),
                      SpaceRow(
                        heading: 'Mail Back :',
                        value: "\$${model.overnight ?? ''}",
                      ),
                      sbh(20),
                      SpaceRow(
                        heading: '         ',
                        value: "Total \$${model.totalAmount}",
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CC.primary,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          sbh(5),
                          Text(
                            maxLines: 5,
                            "${model.picuplocation} ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18),textAlign: TextAlign.center,
                          ),
                          sbh(5),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
  Future<void> acceptRejectRequest(BuildContext context,String status,String requestId) async {
    agent_id=await getCurrentUserId();
    try {
      String url = "https://dcmdmobilenotary.com/laravel/api/get_driver_change_status?request_id=$requestId&status=$status&agent_id=$agent_id";
      final response = await http.get(Uri.parse(url));

      var responseData = json.decode(response.body);
      // final res = await api().post('get_driver_change_status',
      //     data: {"request_id": requestId,"status": status});
      //print("res from login data2 ------------------${res.data}");

      print("res from login data2 ------------------${responseData}");
      final data = GetDriverChangeStatusModel.fromJson(responseData);
      if (data.status == "success") {
        if(status =="Accept"){
          setState(() {
            showProgressbar=true;
            getNewPendingBookingAll();
          });
          print('You have Accepted the booking request');
          showToastMessage('You have Accepted the booking request');
          showSnackbar(context, "You have Accepted the booking request");
        }
        else{
          print('You have Cancelled the booking request');
          showToastMessage('You have Cancelled the booking request');
          showSnackbar(context, "You have Cancelled the booking request");
        }
      } else {
        showSnackbar(context,"${data.message}");
      }
    } catch (e) {
      setState(() {

      });
      print("Error:-"+e.toString());
      //showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GetBuilder<GlobalLocalData>(
        init:GlobalLocalData() ,
        builder: (value){
          if(value.paymentComplete.value){
           setState(() {

           });
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=0;
                            showProgressbar=true;
                            getNewPendingBookingAll();
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color:CC.primary,width: 1),
                              color: tabIndex==0?CC.primary:Colors.white
                          ),
                          child: Center(
                            child:CustomText(
                              text: "Scheduled",
                              textColor:tabIndex==0?Colors.white: CC.primary,fontSize: 14,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=1;
                            showProgressbar=true;
                            getNewPendingBookingAll();
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color:CC.primary,width: 1),
                              color: tabIndex==1?CC.primary:Colors.white
                          ),
                          child: Center(
                            child:CustomText(
                              text: "On Signing",
                              textColor:tabIndex==1?Colors.white: CC.primary,fontSize: 14,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=2;
                            showProgressbar=true;
                            getNewPendingBookingAll();
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color:CC.primary,width: 1),
                              color: tabIndex==2?CC.primary:Colors.white
                          ),
                          child: Center(
                            child:CustomText(
                              text: "Completed",
                              textColor:tabIndex==2?Colors.white: CC.primary,fontSize: 14,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=3;
                            showProgressbar=true;
                            getNewPendingBookingAll();
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: CC.primary,width: 1),
                              color: tabIndex==3?CC.primary:Colors.white
                          ),
                          child: Center(
                            child:CustomText(
                              text: "Canceled",
                              textColor:tabIndex==3?Colors.white: CC.primary,fontSize: 14,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      )
                  )
                ],
              ),
              presentData?
              showScheduledList():const Text("There are not present any signing list.",style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.normal,color: Colors.redAccent,),textAlign: TextAlign.center,)
            ],
          );
        },
      )
    );
  }


  /// Show Scheduled List...
  Widget showScheduledList() {
    return showProgressbar ?
    Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        enabled: showProgressbar,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10 ),
                margin: const EdgeInsets.only(top: 5,bottom: 5),
                decoration: BoxDecoration(
                   border: Border.all(color: Colors.black87,width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))

                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 30, width:50,
                          margin: const EdgeInsets.only(
                              left: 5, right: 5, top: 5),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 15,
                            margin: EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.black
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 15,width: 150,
                                margin: EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.black
                                ),
                              ),
                              Container(
                                height: 15, width: 50,
                                margin: EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              );
            }
        )
    ) :
    ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount:getNewPendingBookingData!.length,
      itemBuilder: (context, int index) {
        GetNewPendingBookingData item=getNewPendingBookingData![index];
        return GestureDetector(
          onTap: (){
            if(tabIndex==0 && item!=null){
              print("Payment Status"+item.paymentStatus!);
              if(item.paymentStatus=="Pending"){
                checkPaymentStatusAlertDialog(context);
              }else{
                startSigningPage(item);
              }

            }if(tabIndex==1 && item!=null){
              print("Payment Status"+item.paymentStatus!);
              if(item.paymentStatus=="Pending"){
                checkPaymentStatusAlertDialog(context);
              }else{
                startSigningPage(item);
              }
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10 ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          carIcon(tabIndex),
                          height: 35,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      ),),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          text: item.picuplocation??'',
                          textColor: Colors.black87,fontSize: 13,fontWeight: FontWeight.normal,textAlign: TextAlign.start,),
                       const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: item.picklaterdate??'',
                              textColor: Colors.black87,fontSize: 13,fontWeight: FontWeight.normal,textAlign: TextAlign.start,),
                            CustomText(
                              text:item.status??'',
                              textColor: CC.primary,fontSize: 14,fontWeight: FontWeight.bold,textAlign: TextAlign.end,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String carIcon(int index){
    switch(index){
      case 2:{
        return 'assets/icons/cargreen.png';
      }
      case 3:{
        return 'assets/icons/carred.png';
      }
      case 0:{
        return 'assets/icons/carblue.png';
      }
      case 1:{
        return 'assets/icons/carblue.png';
      }
    }
    return 'assets/icons/cargreen.png';

  }

  checkPaymentStatusAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      title:  Center(
        child: Text(
          "Notary Agent",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: Text(
        "Waiting for client confirm.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ) ,
      actions: [
        Center(
          child: GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "OK",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  startSigningPage(GetNewPendingBookingData model) async{
   await context.navigate(() => TrackSigning(getNewPendingBookingData: model,));
   setState(() {
     showProgressbar =true;
     getNewPendingBookingAll();
   });
  }

}