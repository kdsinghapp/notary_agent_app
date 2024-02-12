import 'package:flutter/material.dart';
import 'package:notary_agent_app/import.dart';
import 'package:shimmer/shimmer.dart';

import '../../apis/CustomSnackBar.dart';
import '../../apis/interceptor.dart';
import '../../models/GetNewPendingBookingModel.dart';
import '../../models/bookingChangeStatusModel.dart';
import '../../models/getAllBookingModel.dart';
import '../../utils/auth.dart';
import '../../utils/colors.dart';
import '../../widgets/checkoutUI.dart';
import '../home/tracking_signing.dart';

class MySignings extends StatefulWidget {
  const MySignings({Key? key}) : super(key: key);

  @override
  State<MySignings> createState() => _MySigningsState();
}

class _MySigningsState extends State<MySignings> {
  bool showProgressbar=true;
  bool presentData=true;
  String agent_id='';
  int tabIndex=0;
  List<GetNewPendingBookingData>? getNewPendingBookingData;
  var bookingStatus;
  List<GetAllBookingResult>? getAllBookingResult;

  changeStatus(String status, String requestId) async {
    try {
      final res = await api().post('driver_accept_and_Cancel_request', data: {
        "status": status,
        "request_id": requestId,
        "driver_id": await getCurrentUserId()
      });
      // final resdata = UpdateOnlineStatus.fromJson(res as Map<String, dynamic>);
      // print("resdata is....${resdata.data}");
      print("res from login data2 ------------------${res.data}");
      getBookingAll();
      print("status ------------------${res.data['status']}");
      final data = BookingChangeStatusModel.fromJson(res.data);
      if (data.status == "true") {

        if (status == "Accept") {
          showSnackbar(context, "You have Accepted the booking request");
        } else {
          showSnackbar(context, "You have Cancelled the booking request");
        }
      } else {
        showSnackbar(context, "${data.message}");
      }
    } catch (e) {
      showError(context, e);
    }
  }

  getBookingAll() async {
    try {
      final res = await api().post('get_runing_booking',
          data: {"user_id": await getCurrentUserId()});
      // final resdata = UpdateOnlineStatus.fromJson(res as Map<String, dynamic>);
      // print("resdata is....${resdata.data}");
      print("res from login data2 ------------------${res.data}");
      print("status ------------------${res.data['status']}");

      final data = GetAllBookingModel.fromJson(res.data);
      if (data.status == "true") {
   //     getAllBookingResult = data.data;
        setState(() {});
      } else {
        showSnackbar(context, "${data.message}");
      }
    } catch (e) {
      showError(context, e);
    }
  }

  @override
  // ignore: must_call_super
  initState() {
    //getBookingAll();
    getAllBookingRequest();
  }

  getAllBookingRequest() async {
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
        return 'give_driver_completed_request_id';
      }
      case 1:{
        return 'get_driver_cancel_booking';
      }
    }
    return 'give_driver_completed_request_id';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signings Date"),),
     /* appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Image.asset('assets/images/h1.png', height: 56)),
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: CC.primary,
            ),
            onPressed: () {
              // scaffoldKey.currentState!.openDrawer();
              Navigator.pop(context);
            }),
      ), */
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child:
        /* SingleChildScrollView(
          child: getAllBookingResult == null
              ? const Center(child: Text('No requests found'))
              : Column(
            children: [
              // Container(
              //   color: CC.primary,
              //   padding: EdgeInsets.symmetric(vertical: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       CustomText(
              //         text: "GoOffline",
              //         textColor: Colors.white,
              //       ),
              //       Switch(
              //         // This bool value toggles the switch.
              //           activeColor: Colors.white,
              //           value: true,
              //           onChanged: (cc) {
              //             // controller.changeSwitch(context, cc);
              //           }),
              //       CustomText(
              //         text: "GoOnline",
              //         textColor: Colors.white,
              //       ),
              //     ],
              //   ),
              // ),
              // sbh(30),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width - 32,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Column(
              //           children: [
              //             ClipRRect(
              //               child: Image.asset(
              //                 "assets/images/p1.png",
              //                 height: 43,
              //                 width: 43,
              //                 fit: BoxFit.contain,
              //               ),
              //             ),
              //             sbh(10),
              //             CustomText(
              //               text: "Home",
              //               fontSize: 12,
              //             )
              //           ],
              //         ),
              //         Column(
              //           children: [
              //             ClipRRect(
              //               child: Image.asset(
              //                 "assets/images/p2.png",
              //                 height: 43,
              //                 width: 43,
              //                 fit: BoxFit.contain,
              //               ),
              //             ),
              //             sbh(10),
              //             CustomText(
              //               text: "Earning",
              //               fontSize: 12,
              //             )
              //           ],
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             // Navigator.push(
              //             //     context,
              //             //     MaterialPageRoute(
              //             //         builder: (context) => ProfileScreen()));
              //           },
              //           child: Column(
              //             children: [
              //               ClipRRect(
              //                 child: Image.asset(
              //                   "assets/images/p3.png",
              //                   height: 43,
              //                   width: 43,
              //                   fit: BoxFit.contain,
              //                   // color: Colors.grey,
              //                 ),
              //               ),
              //               sbh(10),
              //               CustomText(
              //                 text: "Profile",
              //                 fontSize: 12,
              //               )
              //             ],
              //           ),
              //         ),
              //         Column(
              //           children: [
              //             ClipRRect(
              //               child: Image.asset(
              //                 "assets/images/p4.png",
              //                 height: 43,
              //                 width: 43,
              //                 fit: BoxFit.contain,
              //               ),
              //             ),
              //             sbh(10),
              //             CustomText(
              //               text: "Signing",
              //               fontSize: 12,
              //             )
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              //  sbh(30),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: getAllBookingResult!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.asset(
                          "assets/images/car.png",
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                        title: Text(
                            getAllBookingResult![index].dropofflocation),
                        trailing: GestureDetector(
                          onTap: () {
                            if (getAllBookingResult![index].status ==
                                "Cancel") {
                            } else if (getAllBookingResult![index]
                                .status ==
                                "Accept") {
                              changeStatus("Arrived",getAllBookingResult![index].id.toString());
                            }
                            else if (getAllBookingResult![index]
                                .status ==
                                "Arrived") {
                              changeStatus("Start",getAllBookingResult![index].id.toString());
                            }
                            else if (getAllBookingResult![index]
                                .status ==
                                "Start") {
                              changeStatus("End",getAllBookingResult![index].id.toString());
                            }
                            else if (getAllBookingResult![index]
                                .status ==
                                "End") {
                              changeStatus("Finish",getAllBookingResult![index].id.toString());
                            }
                            if (getAllBookingResult![index].status ==
                                "Finish") {}
                            // controller.acceptRejectRequest(context, "Accept",
                            //     bookingRequestResult!.id.toString());
                          },
                          child: getAllBookingResult![index].status ==
                              "Cancel"
                              ? Text(
                            "Request Cancelled",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ):
                          getAllBookingResult![index].status ==
                              "Finish"
                              ?
                          Text(
                            "Ride Finished",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ):
                          Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(5),
                              color: Colors.green,
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 8),
                              child:
                              Text(    ""
                               /* getAllBookingResult![index].status=="Accept"?"Arrived":
                                getAllBookingResult![index].status=="Arrived"?"Start":
                                getAllBookingResult![index].status=="Start"?"End":
                                getAllBookingResult![index].status=="End"?"Finish":
                                getAllBookingResult![index].status*/,
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
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),   */
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              tabIndex=0;
                              showProgressbar=true;
                              getAllBookingRequest();
                            });
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                borderRadius: const  BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color:CC.primary,width: 1),
                                color: tabIndex==0?CC.primary:Colors.white
                            ),
                            child: Center(
                              child:CustomText(
                                text: "Completed",
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
                              getAllBookingRequest();
                            });
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                              borderRadius: const  BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: CC.primary,width: 1),
                                color: tabIndex==1?CC.primary:Colors.white
                            ),
                            child: Center(
                              child:CustomText(
                                text: "Canceled",
                                textColor:tabIndex==1?Colors.white: CC.primary,fontSize: 14,fontWeight: FontWeight.bold,),
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
              presentData?
              showCompleteCancelList():const Text("There are not present any signing list.",style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.normal,color: Colors.redAccent,),textAlign: TextAlign.center,)
            ],
          ),
        )
      ),
    );
  }

  /// Show My Complete/Cancel Booking Request List...
  Widget showCompleteCancelList() {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                            height: 15,width: 150,
                            margin: EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.black
                            ),
                          ),
                          Container(
                            height: 15,width: 50,
                            margin: EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.black
                            ),
                          ),
                          Container(
                            height:25,
                            margin: EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.black
                            ),
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
        return InkWell(
          onTap: (){
            startSigningPage(item);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 1),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Image.asset("assets/icons/calendar.png",
                      height: 40,width: 40,),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SIGNING DATE :- \n ${item.picklaterdate}",
                        style:const TextStyle(fontWeight: FontWeight.bold,fontSize:
                        16),) ,
                      sbh(10),
                      Text("SIGNING LOCATION \n ${item.picuplocation}",style:const TextStyle(fontSize: 15),) ,
                      sbh(07),
                      Container(
                        // width: MediaQuery.of(context).size.width/3,
                          decoration: BoxDecoration(
                              color: item.status!="End"?Colors.redAccent:Colors.blue,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding:const  EdgeInsets.symmetric(vertical: 8,),
                          child: Center(child: Text(tabIndex==0?'Completed':'Canceled', style: const TextStyle(color: Colors.white),)))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  startSigningPage(GetNewPendingBookingData model) async{
    await context.navigate(() => TrackSigning(getNewPendingBookingData: model,));
    setState(() {
      showProgressbar =true;
      getAllBookingRequest();
    });
  }
}
