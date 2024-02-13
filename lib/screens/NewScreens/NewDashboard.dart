
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:notary_agent_app/apis/CustomSnackBar.dart';
import 'package:notary_agent_app/models/GetDriverChangeStatusModel.dart';
import 'package:notary_agent_app/models/LoginModel.dart';
import 'package:notary_agent_app/models/UserProfileModel.dart';
import 'package:notary_agent_app/screens/agent/BookingStatus.dart';
import 'package:notary_agent_app/screens/agent/MySignings.dart';
import 'package:notary_agent_app/screens/agent/MyWallet.dart';
import 'package:notary_agent_app/screens/home/currentShipping.dart';
import 'package:notary_agent_app/utils/auth.dart';
import 'package:notary_agent_app/utils/global_local_data.dart';

import '../../import.dart';
import 'package:http/http.dart' as http;
import '../../models/GetDriverPendingBookingModel.dart';
import '../../models/GetNewPendingBookingModel.dart';
import '../../models/RequestNotificationInfoModel.dart';
import '../../services/locationService.dart';
import '../../widgets/ShowToast.dart';
import '../home/home/HelpScreen.dart';
import 'EarningPage.dart';
import 'ProfilePage.dart';
import 'SigningPage.dart';

class NewDashboardScreen extends StatefulWidget {
  final bool isRequest;
  const NewDashboardScreen({super.key, required this.isRequest});

  @override
  State<NewDashboardScreen> createState() => _NewDashboardScreenState();
}

class _NewDashboardScreenState extends State<NewDashboardScreen> {
  GoogleMapController? xController;
  int tabIndex=0;
  bool switchh=false;
  bool pageLoading=true;
  String agent_id='';
  //Set<Marker> get markers => {};
  Map<MarkerId, Marker> markers = {};
  LatLng _initialposition = LatLng(22.234,75.24546);
  LocationData? currentLocation;
  LatLng _markerLocation = LatLng(0.0, 0.0); // Initial marker location
  RequestNotificationInfoModel? requestNotificationInfoModel;
  List<GetNewPendingBookingData>? getNewPendingBookingData;
  RequestNotificationResult? requestIdModel;
  LoginModel? driverData;
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
      if (data.status == "1") {
        if(status =="Accept"){
          showToastMessage('You have Accepted the booking request');
          print('You have Accepted the booking request');
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
    setState(() {
      tabIndex=3;
    });
  }
  Future<void> onlineOfflineStatus(BuildContext context,String status) async {
    try {
      final res = await api().post('update_online_status',
          data: {"id": await getCurrentUserId(),"status": status});
      print("res from updateOnline_status data ------------------${res.data}");
      if (res.data['status'] == "true") {
        updateUserDetails(res.data);
        print('update status:-'+res.data['message']);
        showToastMessage(res.data['message']??'');
      } else {
        showSnackbar(context,"${res.data['message']}");
      }
    } catch (e) {
      print("Error:-"+e.toString());
      //showError(context, e);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    controller = controller;
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getAllDriverData();
    print("widget.isRequest--------${widget.isRequest}");
    if(widget.isRequest){
      Future.delayed(Duration.zero, ()
      {
        getPop();
      });
    }else{
      //getRecentPendingBookingApi();
    }
    addMarker(LatLng(22.234, 75.24546), "1",);
  }
  getAllDriverData() async{
    driverData= await getDriverDetails();
    setState(() {
      switchh=driverData!.data!.onlineStatus=='ONLINE'?true:false;
      print('Online status---->>>>${driverData!.data!.onlineStatus}');

      pageLoading=false;
    });
  }
  addMarker(LatLng position, String id) async{
    BitmapDescriptor descriptor= await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 3.2),
        "assets/icons/quic_car_.png");
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  //GetAllBookingResult? getAllBookingResult;
  getBookingAll() async {
    String id=GlobalLocalData.getRequestId();
    try {
      final res = await api().post('get_request_info',
          data: {"request_id":id});
      print("res from login data2 ------------------${res.data}");
      final data = RequestNotificationInfoModel.fromJson(res.data);
      if (data.status == "1") {
        requestNotificationInfoModel = data;
        requestIdModel=requestNotificationInfoModel!.requestId![0];
        //setState(() {});
      } else {
        showSnackbar(context, "${data.message}");
      }
    } catch (e) {
      showError(context, e);
    }
  }
  showPop(GetDriverPendingBookingData model){
    return   showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(minutes: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.grey.withOpacity(0.4),
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
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
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
              ),
              sbh(5),
              Container(
                height: 250,
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
                                text: '${model.carTypeName!}\nTotal '
                                    'Price\$'
                                    ' ${model.totalAmount!} ',
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
                        // value: '\$${fairRideData!.weekend ?? '00'}',
                        value: '\$${model.weekend!}',
                      ),

                      SpaceRow(
                        heading: 'Date:',
                        value: model.picklaterdate ?? '',
                      ),
                      SpaceRow(
                        heading: 'Time:',
                        value: model.picklatertime?? '', ),
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
                        // value: fromData!.name ?? '',
                      ),
                      SpaceRow(
                        heading: 'Real Estate Signing:',
                        value: '${model.realstateSigning}',
                        // value: fromData!.realstateSigning ?? '',
                      ),
                      SpaceRow(
                        heading: 'Email to print:',
                        value: '\$${model .emailtoprit}',
                        // value: '\$${fairRideData!.emailtoprit ?? ' '}',
                      ),
                      SpaceRow(
                        heading: 'Scan and Email:',
                        value: "\$${model .scanandemail}",
                        // value: "\$${fairRideData!.scanandemail ?? ''}",
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
  getPop()async{
    print('start pop calling....');
     await getBookingAll();
    print('start pop calling end ....');
   return   showDialog(
     context: context,
     builder: (BuildContext context) {
       Future.delayed(const Duration(minutes: 3), () {
         Navigator.pop(context);
       });
       return AlertDialog(
         contentPadding: EdgeInsets.all(0),
         backgroundColor: Colors.grey.withOpacity(0.4),
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
             if(requestIdModel!.status.toString() =="Pending")
             Container(
               padding: EdgeInsets.all(16),
               color:Colors.grey.withOpacity(0.4),
               child:Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   GestureDetector(
                     onTap: () {
                       acceptRejectRequest(context,'Cancel_by_driver',
                           requestIdModel!.id.toString());
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
                           requestIdModel!.id.toString());
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
                   fontSize: 16.0,
                   fontWeight: FontWeight.w700,
                 ),
               ),
             ),
             Container(
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
             ),
             sbh(5),
             Container(
               height: 250,
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
                               text: '${requestIdModel!.carTypeName!}\nTotal '
                                   'Price\$'
                                   ' ${requestIdModel!.totalAmount!} ',
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
                       // value: '\$${fairRideData!.weekend ?? '00'}',
                       value: '\$${requestIdModel!.weekend!}',
                     ),

                     SpaceRow(
                       heading: 'Date:',
                        value: requestIdModel!.picklaterdate ?? '',
                      ),
                     SpaceRow(
                       heading: 'Time:',
                       value: requestIdModel!.picklatertime?? '', ),
                     SpaceRow(
                       heading: 'Witness:',
                       value: '${requestIdModel!.witness}',
                     ),
                     SpaceRow(
                       heading: 'Type of Signing:',
                       value: '${requestIdModel!.typeOfSigningName}',
                     ),
                     SpaceRow(
                       heading: 'Location Type:',
                       value: '${requestIdModel!.locationType}',
                     ),
                     SpaceRow(
                       heading: 'Number of Signing:',
                       value:  '${requestIdModel!.numberOfSigning}',
                     ),
                     SpaceRow(
                         heading: 'Signing Location :',
                         value: "${requestIdModel!.picuplocation}"),
                     SpaceRow(
                       heading: 'Name:',
                       value:  '${requestIdModel!.name}',
                       // value: fromData!.name ?? '',
                     ),
                     SpaceRow(
                       heading: 'Real Estate Signing:',
                       value: '${requestIdModel!.realstateSigning}',
                       // value: fromData!.realstateSigning ?? '',
                     ),
                     SpaceRow(
                       heading: 'Email to print:',
                       value: '\$${requestIdModel! .emailtoprit}',
                       // value: '\$${fairRideData!.emailtoprit ?? ' '}',
                     ),
                     SpaceRow(
                       heading: 'Scan and Email:',
                       value: "\$${requestIdModel! .scanandemail}",
                       // value: "\$${fairRideData!.scanandemail ?? ''}",
                     ),
                     SpaceRow(
                       heading: 'Prepaid:',
                       value: '\$${requestIdModel!.prepaid ?? ''}',
                     ),
                     SpaceRow(
                       heading: 'Mail Back :',
                       value: "\$${requestIdModel!.overnight ?? ''}",
                     ),
                     sbh(20),
                     SpaceRow(
                       heading: '         ',
                       value: "Total \$${requestIdModel! .totalAmount}",
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
                           "${requestIdModel! .picuplocation} ",
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
  getRecentPendingBookingApi() async {
    agent_id=await getCurrentUserId();
    try {
      final res = await api().post('get_driver_new_pending_booking',
          data: {"agent_id":agent_id});
      print("res get driver new pending booking  ------------------${res.data}");
      final data = GetDriverPendingBookingModel.fromJson(res.data);
      if (data.status == "true") {
        showPop(data.data![0]);
      } else {
        showSnackbar(context, "${data.message}");
      }
    } catch (e) {
      showError(context, e);
    }
  }
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  ///all tabs .....
  Widget openTab(int index){
    switch(index){
      case 0:{
        return homeMapPage();
      }break;
      case 1:{
        return const EarningPage();
      }break;
      case 2:{
        return const ProfilePage();
      }break;
      case 3:{
        return const SigningPage();
      }break;
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: pageLoading?null: Drawer(
      backgroundColor: Colors.black,
      child: Container(
        child: Column(
          children: [
            sbh(50),
            ListTile(
              onTap: () {},
              leading: SizedBox(
                  height: 60.0,
                  width: 60.0, // fixed width and height
                  child:  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(30.0),
                    child:CachedNetworkImage(
                      imageUrl:'${driverData!.data!.image}',height: 60, width: 60, fit: BoxFit.fill,
                      placeholder: (BuildContext context, String url) =>Image.asset('assets/images/profile.png',height: 60, width: 60, fit: BoxFit.contain,),
                      errorWidget: (BuildContext context, String url, dynamic error) => Image.asset('assets/images/profile.png',height: 60, width: 60, fit: BoxFit.contain,),
                    ),
                  ),

              ),
              title: CustomText(text: '${driverData!.data!.firstName} ${driverData!.data!.lastName}', textColor: Colors.white),
              subtitle: CustomText(
                  text: '${driverData!.data!.email}', textColor: Colors.white),
            ),
            sbh(5),
            Container(
              height: 1,
              color: Colors.white,
            ),
            sbh(5),
            ListTile(
              onTap: () {
                context.pop();
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/images/1.png')),
              title: const CustomText(text: 'Home', textColor: Colors.white),
            ),

            ListTile(
              onTap: () {
                context.pop();
                context.navigate(() => const ChangePassword());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/images/2.png')),
              title: const CustomText(
                  text: 'Change Password', textColor: Colors.white),
            ),
            ListTile(
              onTap: () {
                context.pop();
                context.navigate(() => const MyWalletScreen());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset('assets/images/3.png')),
              title:
              const CustomText(text: 'My wallet', textColor: Colors.white),
            ),
            ListTile(
              onTap: () {
                context.pop();
                context.navigate(() => const MySignings());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset('assets/icons/signing_stering.png')),
              title:const CustomText(
                  text: 'My Signings', textColor: Colors.white),
            ),
           /* ListTile(
              onTap: () {
                context.pop();
                context.navigate(() => const CurrentShipping());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset('assets/images/4.png')),
              title: CustomText(
                  text: 'Current Shipping', textColor: Colors.white),
            ),
            ListTile(
              onTap: () {
                context.pop();
                context.navigate(() => const ContactUs());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset('assets/images/5.png')),
              title: const CustomText(text: 'Emergency Contact', textColor: Colors.white),
            ),  */
            ListTile(
              onTap: () {
                context.pop();
                context.navigate(() => const AboutUsScreen());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset('assets/images/6.png')),
              title: const CustomText(text: 'About Us', textColor: Colors.white),
            ),
            ListTile(
              onTap: () {
                context.pop();
                context.navigate(() => const SettingScreen());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset('assets/images/7.png')),
              title: const CustomText(text: 'Setting', textColor: Colors.white),
            ),
            ListTile(
              onTap: () {
                logout();
                context.pop();
                context.navigate(() => const Login());
              },
              leading: SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset('assets/images/8.png')),
              title: CustomText(text: 'Log Out', textColor: Colors.white),
            ),
          ],
        ),
      ),
    ),
      appBar: AppBar(
        backgroundColor: CC.primary,
        elevation: 0,
        title: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Image.asset('assets/images/logo.png', height: 56)),
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: CC.white,
            ),
            onPressed: () {
              print("object");
              if(scaffoldKey.currentState!=null)
              scaffoldKey.currentState!.openDrawer();
             
            }),
        actions: [
          GestureDetector(
            onTap: (){
              context.navigate(() => HelpScreen());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  CustomText(
                    text: "HELP",
                    textColor: Colors.white,fontSize: 16,
                  ),
                  Icon(Icons.help,color: Colors.white,size: 25,)
                ],
              ),
            ),
          )
        ],
      ),
      body:pageLoading?
          const Center(child: CircularProgressIndicator(),):
       Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  color: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CustomText(
                        text: "OFFLINE",
                        textColor: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),
                      Switch(
                        // This bool value toggles the switch.
                          inactiveTrackColor: Colors.white.withOpacity(0.5),
                          activeTrackColor: Colors.green,
                          activeColor: Colors.white,
                          value: switchh,
                          onChanged: (cc) {
                            setState(() {
                              switchh=cc;
                              if(cc){
                                onlineOfflineStatus(context,'ONLINE');
                              }else{
                                onlineOfflineStatus(context,'OFFLINE');
                              }
                              //getPop();
                            });
                          }),
                      const CustomText(
                        text: "ONLINE",
                        textColor: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 58,
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=0;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,width: 30,
                              child:Image.asset(tabIndex==0?'assets/icons/home_fill.png':'assets/icons/home.png',fit: BoxFit.fill,) ,),
                            CustomText(
                              text: "Home",
                              textColor:tabIndex==0?CC.accentDark:Colors.black87,fontSize: 14,fontWeight: FontWeight.normal,),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=1;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,width: 30,
                              child:Image.asset(tabIndex==1?'assets/icons/earning_fill.png':'assets/icons/earning.png',fit: BoxFit.fill,) ,),
                            CustomText(
                              text: "Earning",
                              textColor:tabIndex==1 ?CC.accentDark:Colors.black87,fontSize: 14,fontWeight: FontWeight.normal,),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=2;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,width: 30,
                              child:Image.asset(tabIndex==2?'assets/icons/profile_fill.png':'assets/icons/profile.png',fit: BoxFit.fill,) ,),
                            CustomText(
                              text: "Profile",
                              textColor:tabIndex==2?CC.accentDark:Colors.black87,fontSize: 14,fontWeight: FontWeight.normal,),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            tabIndex=3;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,width: 30,
                              child:Image.asset(tabIndex==3?'assets/icons/signing_fill.png':'assets/icons/signing.png',fit: BoxFit.fill,) ,),
                            CustomText(
                              text: "Signing",
                              textColor:tabIndex==3?CC.accentDark:Colors.black87,fontSize: 14,fontWeight: FontWeight.normal,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: openTab(tabIndex),
                  ),
                ),
                /*Container(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    child:
                    // controller.activegps.value == false? InkWell(onTap: (){
                    //       // controller.getUserLocation();
                    //     },
                    //     child: Container(
                    //     )):
                    GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      markers: markers,
                      // onCameraMove: controller.onCameraMove,
                      initialCameraPosition: CameraPosition(
                          target: _initialposition, zoom: 18.0),
                      onMapCreated: (controller) {
                        setState(() {
                          _controller = controller;
                          _zoomToLocation();
                        });
                      },
                      myLocationEnabled: true,
                      // onCameraIdle: () async {
                      //   controller.getMoveCamera();
                      // },
                    ),
                  ),
                ),  */
              ],
            ),
          ),
          // Positioned(
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(18.0),
          //             child: Visibility(
          //               visible: controller.directionVisibility,
          //               child: AppButton(
          //                 onTap: () async{
          //                   // await controller.getBookingRequest(context);
          //                   controller.direct(context);
          //                   controller.changeDirectionVisibility(context);
          //                 },
          //                 text: "Direction",
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       GestureDetector(
          //         // onTap: () => context.navigate(() => AddRequestForm()),
          //         child: Container(
          //           width: MediaQuery.of(context).size.width,
          //           padding: EdgeInsets.all(16),
          //           color: Colors.white,
          //           child: CustomText(
          //             text:
          //             "Signing Request 20 January 2001 1414520 \nTedays Earning \$ 127.00",
          //             fontSize: 16,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          //   bottom: 0,
          //   width: context.width,
          // ),
        ],
      ),

    );
  }

  Widget homeMapPage(){
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Container(
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              markers: Set<Marker>.of(markers.values),
              // onCameraMove: controller.onCameraMove,
              initialCameraPosition: CameraPosition(
                target: _initialposition,
                zoom: 15.0,
              ),
              // onMapCreated: (GoogleMapController mcontroller) async {
              //   controller = xController;
              //   if (xController != null) {
              //     await xController!.animateCamera(
              //       CameraUpdate.newLatLngZoom(startLocation.value, 16),
              //     );
              //   }
              //   // controllerCompleter.complete(mcontroller);
              //
              //   // setState(() async {
              //   //
              //   // });
              // },
              onMapCreated: (controller) {
                setState(() {
                  xController = controller;
                  _zoomToLocation();
                });
              },
              myLocationEnabled: true,
              /*onTap: (LatLng location) {
                setState(() {
                  markers.clear();
                  markers.add(
                    Marker(
                      markerId: MarkerId('tapped_location'),
                      position: location,
                      // infoWindow: InfoWindow(title: 'TODOapped Location'),
                    ),
                  );
                });
                // setState(() {
              //  getAddressFromCoordinates(location.latitude, location.longitude);
                startLocation.value = LatLng(location.latitude, location.longitude);
                // });
              },  */
            ),
            Positioned(
              bottom: 0,
                child: Container(
                  height: 100,width:MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10,right: 30,top: 10),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Signing Request',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red),),
                      Align(
                        alignment: Alignment.centerRight,
                        child:  GestureDetector(
                            onTap: (){
                              context.navigate(() => MySignings());
                            },
                            child:SizedBox(
                              height: 35,
                              width: 35,
                              child: Image.asset('assets/icons/calendar.png',fit: BoxFit.fill,),
                            )
                        ),
                      ),
                      const Text('Today Earning',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red),),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  void _zoomToLocation() async {
    if (xController != null) {
      final CameraPosition newPosition = CameraPosition(
        target: _initialposition,
        zoom: 16.0, // Adjust the zoom level as needed
      );

      await xController!
          .animateCamera(CameraUpdate.newCameraPosition(newPosition));

    }
  }
}
