import 'package:flutter/material.dart';
import 'package:notary_agent_app/models/getAllBookingModel.dart';
import 'package:notary_agent_app/screens/agent/profile.dart';

import '../../apis/CustomSnackBar.dart';
import '../../apis/interceptor.dart';
import '../../models/bookingChangeStatusModel.dart';
import '../../utils/auth.dart';
import '../../utils/colors.dart';
import '../../utils/util_funcs.dart';
import '../../widgets/checkoutUI.dart';
import 'dummy.dart';

class BookingStatus extends StatefulWidget {
  const BookingStatus({super.key});

  @override
  State<BookingStatus> createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  var bookingStatus;
  GetAllBookingResult? getAllBookingResult;

  changeStatus(String status, String requestId) async {
    try {
      final res = await api().post('driver_accept_and_Cancel_request', data: {
        "status": status,
        "request_id": requestId,
        "driver_id": await getCurrentUserId()
      });
      print("objestatus--${status}\n${requestId}\n${await getCurrentUserId()}ct") ;
      // final resdata = UpdateOnlineStatus.fromJson(res as Map<String, dynamic>);
      // print("resdata is....${resdata.data}");
      print("res from login data2 ------------------${res.data}");
      getBookingAll();
      print("status ------------------${res.data['status']}");
      final data = BookingChangeStatusModel.fromJson(res.data);
      if (data.status == "true") {
        getBookingAll();
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
        getAllBookingResult = data.data;
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
    getBookingAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Image.asset('assets/images/h1.png', height: 56)),
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: CC.primary,
            ),
            onPressed: () {
              // scaffoldKey.currentState!.openDrawer();
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          child: getAllBookingResult == null
              ? Center(child: Text('No requests found'))
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
                  /*  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: getAllBookingResult!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return HomeScreenPopup(
                              //         bookingRequestResult: _bookingRequestResult,
                              //       );
                                    // return TripPopup ();
                                    //return DoneDialog();
                                    //return CustomDialog();
                                  // });
                            },
                            child: Padding(
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
                                            Text(
                                              getAllBookingResult![index].status=="Accept"?"Arrived":
                                              getAllBookingResult![index].status=="Arrived"?"Start":
                                              getAllBookingResult![index].status=="Start"?"End":
                                              getAllBookingResult![index].status=="End"?"Finish":
                                              getAllBookingResult![index].status,
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
                            ),
                          );
                        },
                      ),
                    )*/
                  ],
                ),
        ),
      ),
    );
  }
}
