// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:notary_agent_app/apis/CustomSnackBar.dart';
// import 'package:notary_agent_app/controllers/dummyController.dart';
// import 'package:notary_agent_app/screens/agent/TrackingPage.dart';
// import 'package:percent_indicator/percent_indicator.dart';
//
// import '../../models/bookingRequestModel.dart';
//
// class HomeScreenPopup extends StatelessWidget {
//   final BookingRequestResult? bookingRequestResult;
//
//   const HomeScreenPopup({Key? key, required this.bookingRequestResult})
//       : super(key: key);
//
//   dialogContent(BuildContext context) {
//     return GetBuilder(
//       init: DummyController(),
//       builder: (DummyController controller) {
//         return Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 633,
//               width: 364,
//               decoration: new BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min, // To make the card compact
//                 children: <Widget>[
//                   SizedBox(
//                     height: 21,
//                   ),
//                   Text('Signing Request'),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 18.0, vertical: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               controller.acceptRejectRequest(context, "Cancel",
//                                   bookingRequestResult!.id.toString());
//                               Navigator.pop(context);
//
//                             },
//                             child: Container(
//                               height: 40,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.red,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: Text(
//                                   "Decline",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               controller.acceptRejectRequest(context, "Accept",
//                                   bookingRequestResult!.id.toString());
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(builder: (context) => TrackingPage()),
//                               // );
//                             },
//                             child: Container(
//                               height: 40,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.green,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: Text(
//                                   "Accept",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20.45),
//                   Container(
//                     height: 182,
//                     width: double.infinity,
//                     color: Colors.black,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "Client",
//                           style: new TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18.0),
//                         ),
//                         SizedBox(
//                           height: 16,
//                         ),
//                         CircularPercentIndicator(
//                           radius: 50.0,
//                           animation: true,
//                           animationDuration: 1200,
//                           lineWidth: 12.0,
//                           percent: 0.9,
//                           center: new Text(
//                             "${bookingRequestResult!.estimateTime}",
//                             style: new TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 10.0),
//                           ),
//                           circularStrokeCap: CircularStrokeCap.butt,
//                           backgroundColor: Colors.yellow,
//                           progressColor: Colors.blue,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(11.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.circle_outlined,
//                           size: 43.35,
//                         ),
//                         SizedBox(
//                           width: 11,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(bookingRequestResult!.carTypeName),
//                             Text("${bookingRequestResult!.carSeats} seats"),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 11.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'After Hour Charge',
//                           style: new TextStyle(
//                               color: Color(0xff000000),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12.0),
//                         ),
//                         Text(
//                           "\$${bookingRequestResult!.overnight}" ?? "",
//                           style: new TextStyle(
//                               color: Color(0xff000000),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12.0),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 11.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Signing Location',
//                           style: new TextStyle(
//                               color: Color(0xff000000),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12.0),
//                         ),
//                         Text(
//                           '${bookingRequestResult!.picuplocation}',
//                           style: new TextStyle(
//                               color: Color(0xff000000),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12.0),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 11.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Drop Off Location',
//                           style: new TextStyle(
//                               color: Color(0xff000000),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12.0),
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               bookingRequestResult!.dropofflocation ?? "",
//                               style: new TextStyle(
//                                   color: Color(0xff000000),
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 12.0),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     height: 143,
//                     width: double.infinity,
//                     color: Color(0xff000F62),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 16,
//                         ),
//                         Text(
//                           "Location",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 4.3,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 26.0),
//                           child: Text(
//                             bookingRequestResult!.picuplocation ?? "",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }
// }


import 'dart:async';

import 'package:notary_agent_app/import.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../apis/CustomSnackBar.dart';
import '../../models/bookingChangeStatusModel.dart';
import '../../models/bookingRequestModel.dart';
import '../../utils/auth.dart';
import 'TrackingPage.dart';

class HomeScreenPopup extends StatefulWidget {
  final BookingRequestResult? bookingRequestResult;
  const HomeScreenPopup({Key? key, this.bookingRequestResult}) : super(key: key);

  @override
  State<HomeScreenPopup> createState() => _HomeScreenPopupState();
}

class _HomeScreenPopupState extends State<HomeScreenPopup> {

  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  double _percentage = 0.0;

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _percentage = _stopwatch.elapsedMilliseconds / (60 * 1000);
          _percentage = _percentage.clamp(0.0, 1.0);
          if (_percentage >= 1.0) {
            _stopwatch.stop();
            _timer.cancel();
            Navigator.pop(context);
          }// Adjust as needed
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Future<void> acceptRejectRequest(String status,String requestId) async {
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
      showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 633,
              width: 364,
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  SizedBox(
                    height: 21,
                  ),
                  Text('Signing Request'),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              acceptRejectRequest("Cancel",
                                  widget.bookingRequestResult!.id.toString());
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
                            onTap: () {
                              acceptRejectRequest("Accept",
                                  widget.bookingRequestResult!.id.toString());
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => TrackingPage()),
                              // );
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
                  ),
                  SizedBox(height: 20.45),
                  CircularPercentIndicator(
                    radius: 50,
                    lineWidth: 10.0,
                    percent: _percentage,
                    center: Text(
                      "${(_stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1)}s",
                      style: TextStyle(fontSize: 20),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.blue,
                  ),
                  SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         if (_stopwatch.isRunning) {
                  //           _stopwatch.stop();
                  //         } else {
                  //           _stopwatch.start();
                  //         }
                  //         setState(() {});
                  //       },
                  //       child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
                  //     ),
                  //     SizedBox(width: 20),
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         _stopwatch.reset();
                  //         setState(() {});
                  //       },
                  //       child: Text('Reset'),
                  //     ),
                  //   ],
                  // ),
                  // Container(
                  //   height: 182,
                  //   width: double.infinity,
                  //   color: Colors.black,
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Text(
                  //         "Client",
                  //         style: new TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 18.0),
                  //       ),
                  //       SizedBox(
                  //         height: 16,
                  //       ),
                  //       CircularPercentIndicator(
                  //         radius: 50.0,
                  //         animation: true,
                  //         animationDuration: 1200,
                  //         lineWidth: 12.0,
                  //         percent: 0.9,
                  //         center: new Text(
                  //           "${widget.bookingRequestResult!.estimateTime}",
                  //           style: new TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 10.0),
                  //         ),
                  //         circularStrokeCap: CircularStrokeCap.butt,
                  //         backgroundColor: Colors.yellow,
                  //         progressColor: Colors.blue,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          size: 43.35,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.bookingRequestResult!.carTypeName),
                            Text("${widget.bookingRequestResult!.carSeats} seats"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'After Hour Charge',
                          style: new TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                        Text(
                          "\$${widget.bookingRequestResult!.overnight}" ?? "",
                          style: new TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Signing Location',
                          style: new TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                        Text(
                          '${widget.bookingRequestResult!.picuplocation}',
                          style: new TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Drop Off Location',
                          style: new TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                        Column(
                          children: [
                            Text(
                              widget.bookingRequestResult!.dropofflocation ?? "",
                              style: new TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 143,
                    width: double.infinity,
                    color: Color(0xff000F62),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Location",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 4.3,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Text(
                            widget.bookingRequestResult!.picuplocation ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
    ]
    );
  }
}
