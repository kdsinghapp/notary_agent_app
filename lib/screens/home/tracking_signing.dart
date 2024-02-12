import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:notary_agent_app/models/UserProfileModel.dart';
import '../../../import.dart';
import '../../apis/CustomSnackBar.dart';
import '../../models/GetDriverChangeStatusModel.dart';
import '../../models/GetNewPendingBookingModel.dart';
import '../../services/apiServices.dart';
import '../../utils/auth.dart';
import '../../widgets/ShowToast.dart';
class TrackSigning extends StatefulWidget{
  const TrackSigning({Key? key,required this.getNewPendingBookingData}) : super(key: key);
  final GetNewPendingBookingData getNewPendingBookingData;
  @override
  State<TrackSigning> createState() =>_TrackSigningState();
}

class _TrackSigningState extends State<TrackSigning> {
  GoogleMapController? _controller;
  //Completer<GoogleMapController> _controller = Completer();
  // Set<Marker> get markers => {};
  LatLng initialposition = LatLng(-12.122711, -77.027475);

  double originLatitude = -12.122711;
  double originLongitude = -77.027475;
  double destLatitude = -12.125711;
  double destLongitude = -77.037475;
  Map<MarkerId, Marker> markers = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.122711, -77.027475),
    zoom: 15.4746,
  );
  String bookingStatus='';
  bool pageLoading=true;
  bool btnLoading=false;
  UserProfileModel? userProfileModel;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
    print("data status -----"+widget.getNewPendingBookingData.status.toString());
    setState(() {
      bookingStatus=widget.getNewPendingBookingData.status??'Accept';
    });
    _addMarker(
      LatLng(originLatitude, originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(originLatitude, originLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );
    // Add destination marker
    _addMarker(
      LatLng(destLatitude, destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();
  }
  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  Future<void> getUserProfile() async {
   // try {
      String url = '${ApiUrls.getProfile}?user_id=${widget.getNewPendingBookingData.userId.toString()}';
      var res = await Webservices.getData(url);
      var jsonResponse = convert.jsonDecode(res.body);
      print("change status url ------------------${url}");
      print("res from login data2 ------------------${jsonResponse}");
      userProfileModel= UserProfileModel.fromJson(jsonResponse);
      if (userProfileModel!.status == "true") {
        print('Successfully get driver profile...');
        setState(() {
          pageLoading=false;
        });

      } else {
        print('Failed get driver profile...');
        showSnackbar(context,"${userProfileModel!.message}");
      }
    // } catch (e) {
    //   showSnackbar(context,"${e.toString()}");
    //   print("Error:-"+e.toString());
    //   //showError(context, e);
    // }
  }
  Future<void> startArrivedRequest(BuildContext context,String status) async {
    String agent_id=await getCurrentUserId();
    try {
      String url = "https://dcmdmobilenotary.com/laravel/api/get_driver_change_status?request_id=${widget.getNewPendingBookingData.id.toString()}&status=$status&agent_id=$agent_id";
      final response = await http.get(Uri.parse(url));
      var responseData = json.decode(response.body);
      print("change status ------------------$url");
      print("res from get_driver_change_status ------------------${responseData}");
      final data = GetDriverChangeStatusModel.fromJson(responseData);
      if (data.status == "1") {
        setState(() {
          bookingStatus =data.result!.status??'';
        });
        showToastMessage('Success +${data.message}');
        print('Success +${data.message}');
        showSnackbar(context, 'Success +${data.message}');
      } else {
        showSnackbar(context,"${data.message}");
      }
    } catch (e) {
      setState(() {

      });
      print("Error:-"+e.toString());
    }
    setState(() {
      btnLoading=false;
    });
  }

  Future<void> rejectRequestApi(BuildContext context,String status,String driverReason) async {
    String agent_id=await getCurrentUserId();
    try {
      String url = "https://dcmdmobilenotary.com/laravel/api/get_driver_change_status?request_id=${widget.getNewPendingBookingData.id.toString()}&status=$status&agent_id=$agent_id&driver_reason=$driverReason";
      final response = await http.get(Uri.parse(url));

      var responseData = json.decode(response.body);

      print("res from login data2 ------------------${responseData}");
      final data = GetDriverChangeStatusModel.fromJson(responseData);
      if (data.status == "1") {
          showToastMessage('You have canceled this booking request');
          print('You have canceled this booking request');
          showSnackbar(context, "You have canceled this booking request");
          Navigator.pop(context);

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
    return Scaffold(
        appBar: appBar(context: context, title: "Your Signing",
          elevation: 0,
          actions:[
            GestureDetector(
              onTap: (){
                cancelAlertDialog(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.cancel_outlined,size:35,color: Colors.white,),
              ),
            )

          ]
        ),
        body:pageLoading?
            const Center(child: CircularProgressIndicator(),):
        GetBuilder(
            init: HomeController(),
            builder: (HomeController controller) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        Container(
                          width:double.infinity,
                          padding: const EdgeInsets.all(18),
                          color: CC.primary,
                          child: Text(widget.getNewPendingBookingData.picuplocation??'', style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height-200,
                            child:MyGoogleMap()
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: context.width,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/msg.png",
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.contain,
                                  ),
                                  Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                        child:CachedNetworkImage(
                                          imageUrl:'${userProfileModel!.data![0].image}',height: 63, width: 63, fit: BoxFit.contain,
                                          placeholder: (BuildContext context, String url) =>Image.asset('assets/images/profile.png',height: 63, width: 63, fit: BoxFit.contain,),
                                          errorWidget: (BuildContext context, String url, dynamic error) => Image.asset('assets/images/profile.png',height: 63, width: 63, fit: BoxFit.contain,),
                                        ),
                                      ),
                                      sbh(3),
                                      CustomText(
                                        text: '${userProfileModel!.data![0].firstName} ${userProfileModel!.data![0].lastName}',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      )
                                    ],
                                  ),
                                  Image.asset(
                                    "assets/images/call.png",
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                             /* sbh(5),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/map.png",
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.contain,
                                  ),
                                  /* GestureDetector(
                                    onTap: (){
                                      //context.navigate(() => AddRate());
                                    },
                                    child: RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      itemSize: 20,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 10,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),  */
                                  SizedBox(width: 80,),
                                  Image.asset(
                                    "assets/images/calendar.png",
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),  */
                              sbh(10),
                            ],
                          ),
                        ),
                        AppButton(
                          onTap: () {
                            buttonOnClick(bookingStatus);
                            // startSigning? showStartSigningAlertDialog(context):showArrivedSigningAlertDialog(context);
                          },
                          text: buttonTitle(bookingStatus),
                          color: Colors.red,
                          loading:btnLoading ,
                        )
                      ],
                    ),

                  ),
                ],
              );
            })
    );
  }

  String buttonTitle(String value){
    switch(value){
      case 'Accept':{
        return 'START SIGNING';
      }
      case 'Start':{
        return 'Arrived';
      }
      case 'Arrived':{
        return 'End';
      }
    }
    return 'Complete';
  }
  void buttonOnClick(String value){
    switch(value){
      case 'Accept':{
        showStartSigningAlertDialog(context);
      }break;
      case 'Start':{
        showArrivedSigningAlertDialog(context);
      }break;
      case 'Arrived':{
        showEndSigningAlertDialog(context);
      }break;
      case '':{
        //showEndSigningAlertDialog(context);
      }
    }
  }


  cancelAlertDialog(BuildContext context) {
    bool reasion1=false,reasion2=false,reasion3=false;
    String? reasion;
    AlertDialog alert = AlertDialog(
      title: const Center(
        child: Text(
          "Are you sure ?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
     content: StatefulBuilder(
         builder: (BuildContext context, StateSetter setState){
           return Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               const Text(
                 "Do you want to cancel this booking?",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.black87,
                   fontSize: 16.0,
                   fontWeight: FontWeight.w700,
                 ),
               ),
               CheckboxListTile(
                 title: const Text('Client requested cancel'),
                 value: reasion1,
                 onChanged: (bool? value) {
                   setState(() {
                     reasion1=value!;
                     reasion='Client requested cancel';
                   });
                 },
               ),
               CheckboxListTile(
                 title: const Text('Wrong address shown'),
                 value: reasion2,
                 onChanged: (bool? value) {
                   setState(() {
                     reasion2=value!;
                     reasion='Wrong address shown';
                   });
                 },
               ),
               CheckboxListTile(
                 title: const Text('Client no-show'),
                 value: reasion3,
                 onChanged: (bool? value) {
                   setState(() {
                     reasion3=value!;
                     reasion='Client no-show';
                   });
                 },
               ),
             ],
           );
         }
     ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  if(reasion!=null){
                    setState(() {
                      Navigator.pop(context);
                      btnLoading=true;
                      rejectRequestApi(context,'Cancel_by_driver',reasion!);
                    });
                  }else{
                    showToastMessage('Please select reason of cancel...');
                  }
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 8,left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CC.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8,right: 5),
                    child: Text(
                      "Yes",
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
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  margin: EdgeInsets.only(top: 8,left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8,left: 5),
                    child: Text(
                      "No",
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
          ],
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
  showStartSigningAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title:  Center(
        child: Text(
          "Start this signing",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    btnLoading=true;
                    startArrivedRequest(context, 'Start');

                  });

                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CC.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Yes",
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
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "No",
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
          ],
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
  showArrivedSigningAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title:  Center(
        child: Text(
          "Agent has arrived.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    btnLoading=true;
                    startArrivedRequest(context, 'Arrived');
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CC.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Yes",
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
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "No",
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
          ],
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
  showEndSigningAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title:  Center(
        child: Text(
          "Agent has completed booking.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    btnLoading=true;
                    startArrivedRequest(context, 'End');
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CC.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Yes",
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
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "No",
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
          ],
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

  Widget MyGoogleMap (){
    return  GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,
      //tiltGesturesEnabled: true,
      compassEnabled: true,
      //scrollGesturesEnabled: true,
      zoomGesturesEnabled: false,
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          _controller=controller;
          _zoomToLocation();
        });
        //_controller.complete(controller);
      },
    );
  }
  void _zoomToLocation() async {
    if (_controller != null) {
      final CameraPosition newPosition = CameraPosition(
        target: initialposition,
        zoom: 16.0, // Adjust the zoom level as needed
      );

      await _controller!
          .animateCamera(CameraUpdate.newCameraPosition(newPosition));

    }
  }
  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      color: Colors.redAccent,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    print('Start polyline drawing ....');
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyABk-AIzaSyCsAl96Phonf22z69GSDlYQOjlDO6NsiWk", //AIzaSyABk-0Al27H9Ap_Rtti2t0ePxOLvl5QFzk
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }



}


